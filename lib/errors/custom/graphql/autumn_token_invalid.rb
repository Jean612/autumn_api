class Errors::Custom::Graphql::AutumnTokenInvalid < StandardError
  def initialize(message = I18n.t(:invalid_autumn_token))
    super(message)
  end

  def messages
    [message]
  end
end
