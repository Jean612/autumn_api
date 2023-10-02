class Errors::Custom::Graphql::NotAuthorized < StandardError
  def initialize(message = I18n.t(:not_authorized_error))
    super(message)
  end

  def messages
    [message]
  end
end
