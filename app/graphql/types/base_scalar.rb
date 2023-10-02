module Types
  class BaseScalar < GraphQL::Schema::Scalar
    include CustomDataTypesValidatorHelper
  end
end
