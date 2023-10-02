class Types::Scalars::Email < Types::BaseScalar
  def self.coerce_input(input_value, _context)
    return input_value if input_value.nil? || CustomDataTypesValidator.email?(input_value)

    raise Errors::Custom::Graphql::InvalidArgumentError, I18n.t('messages.errors.scalars.email', value: input_value)
  end
end
