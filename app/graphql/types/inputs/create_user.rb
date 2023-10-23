module Types
  module Inputs
    # Input for create user mutation
    class CreateUser < BaseInputObject
      argument :birthday,  GraphQL::Types::ISO8601Date, required: false
      argument :email,     Types::Scalars::Email,       required: true
      argument :last_name, String,                      required: true
      argument :name,      String,                      required: true
      argument :password,  String,                      required: true
      argument :phone,     String,                      required: false
    end
  end
end
