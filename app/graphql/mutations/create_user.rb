# frozen_string_literal: true

module Mutations
  # Mutation for regiter user
  class CreateUser < BaseMutation
    null true
    # TODO: improve description
    description 'Registration for users'

    argument :input, Types::Inputs::CreateUser, required: true

    field :data,    Types::UserType,     null: true
    field :message, String,              null: true
    field :success, Boolean,             null: true

    def resolve(input:)
      user = User.create!(**input)
      user.update_attribute(:last_sign_in_at, Time.current)
      {
        data: user,
        message: I18n.t('messages.errors.users.successfully_login'),
        success: true
      }
    rescue ActiveRecord::RecordInvalid => e
      # raise_validation_execution_error(e.record.errors.full_messages[0])
      GraphQL::ExecutionError.new(e.record.errors.full_messages[0])
    end
  end
end
