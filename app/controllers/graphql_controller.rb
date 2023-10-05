class GraphqlController < ApplicationController
  around_action :update_i18n_locale

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]

    raise Errors::Custom::Graphql::NotAuthorized unless token_valid?

    context = {
      current_user: current_gql_user,
      current_ability: current_gql_ability,
      current_host: request.base_url,
      current_request: request
    }

    result = AutumnApiSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: response_format(result, request.headers['Checksum'])
  rescue Errors::Custom::Graphql::AccessDenied => e
    render json: { error: { message: e.message }, data: {} }, status: :forbidden
  rescue Errors::Custom::Graphql::InvalidArgumentError => e
    render json: { errors: [{ message: e.message, extensions: { error_type: :validation } }] }, status: :ok
  rescue JWT::DecodeError
    render json: { error: { message: 'Invalid token' }, data: {} }, status: 403
  rescue Errors::Custom::Graphql::NotAuthorized => e
    render json: { error: { message: e.message }, data: {} }, status: :unauthorized
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end

  def update_i18n_locale(&action)
    requested_lang = request.headers['LANGCODE'].try(:to_sym)

    if I18n.available_locales.include?(requested_lang)
      I18n.with_locale requested_lang, &action
    else
      yield action # will use default_locale
    end
  end

  def token_valid?
    return false if request.headers['HTTP_AUTUMN_TOKEN'].blank?

    request.headers['HTTP_AUTUMN_TOKEN'] == ENV['AUTUMN_TOKEN']
  end

  def response_format(result, before_checksum = nil)
    result[:checksum] = {}
    checksum = Digest::MD5.hexdigest result.to_h.to_s
    result[:checksum][:data] = checksum
    if before_checksum.present?
      if checksum == before_checksum
        result = { checksum: { success: true } }
      else
        result[:checksum][:success] = false
      end
    end
    result
  end

  def current_gql_ability
    @current_gql_ability ||= Ability.new(current_gql_user.presence)
  end

  def current_gql_user
    return @current_gql_user if @current_gql_user

    return unless user_token_present?

    begin
      decoded_token = JWT.decode(request.headers['JWTACCESSTOKEN'], ENV['JWT_SECRET_KEY'], true, { algorithm: 'HS256' }).shift
    rescue JWT::ExpiredSignature => _e
      raise Errors::Custom::Graphql::AccessDenied, I18n.t('messages.errors.jwt.expired_token')
    rescue JWT::DecodeError => _e
      raise Errors::Custom::Graphql::AccessDenied, I18n.t('messages.errors.jwt.invalid_token')
    end

    user_id_from_token = decoded_token['user-id']

    @current_gql_user = User.active.find_by(id: user_id_from_token) || nil
  end

  def user_token_present?
    request.headers['JWTACCESSTOKEN'].present?
  end
end
