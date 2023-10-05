module Types
  class UserType < BaseObject
    field :birthday,         GraphQL::Types::ISO8601Date, null: true
    field :email,            String,                      null: false
    field :id,               ID,                          null: false
    field :last_name,        String,                      null: true
    field :name,             String,                      null: true
    field :fullname,         String,                      null: true
    field :phone,            String,                      null: true
    field :token,            String,                      null: false
    field :verified_account, Boolean,                     null: true

    def token
      object.graphql_token
    end
  end
end
