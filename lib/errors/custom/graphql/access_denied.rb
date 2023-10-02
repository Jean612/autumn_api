class Errors::Custom::Graphql::AccessDenied < StandardError
  def initialize(message = I18n.t('messages.errors.custom.graphql.access_denied'))
    super(message)
  end

  def messages
    [message]
  end
end
