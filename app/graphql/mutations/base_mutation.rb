module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    null false

    def raise_extended_execution_error(message, extensions = nil)
      raise GraphQL::ExecutionError.new(message, extensions:)
    end

    def raise_validation_execution_error(message)
      raise_extended_execution_error(message, { error_type: :validation })
    end
  end
end
