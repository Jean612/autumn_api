module Types
  class MutationType < BaseObject
    field :sign_in_user, mutation: Mutations::SignInUser
  end
end
