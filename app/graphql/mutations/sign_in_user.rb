module Mutations
  class SignInUser < BaseMutation
    null true
    # TODO: improve description
    description 'Sign in for users'

    argument :input, Types::SignInUserInput, required: false

    field :data,    Types::UserType,     null: true
    field :message, String,              null: true
    field :success, Boolean,             null: true

    def resolve(input:)
      user = User.active.find_by_email(input.email)

      raise_validation_execution_error(I18n.t('messages.errors.users.wrong_credentials')) unless user&.valid_password?(input.password)

      user.update_attribute(:last_sign_in_at, Time.current)
      {
        data: user,
        message: I18n.t('messages.errors.users.successfully_login'),
        success: true
      }
    end
  end
end
