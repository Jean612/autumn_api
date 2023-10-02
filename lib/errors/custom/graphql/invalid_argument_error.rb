class Errors::Custom::Graphql::InvalidArgumentError < StandardError
  def initialize(message = I18n.t('messages.errors.custom.graphql.invalid_action_error'))
    super(message)
  end

  def messages
    [message]
  end
end
