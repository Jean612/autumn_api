# frozen_string_literal: true

module Types
  # List of mutations
  class MutationType < BaseObject
    # TODO: Add tests for createUser mutation

    field :sign_in_user, mutation: Mutations::SignInUser
    field :create_user,  mutation: Mutations::CreateUser
  end
end
