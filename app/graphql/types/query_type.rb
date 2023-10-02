module Types
  class QueryType < Types::BaseObject
    field :user, resolver: Resolvers::UserDetails
  end
end
