module Types
  class SignInUserInput < BaseInputObject
    argument :email,    Types::Scalars::Email, required: true
    argument :password, String,                required: true
  end
end
