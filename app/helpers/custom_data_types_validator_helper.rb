module CustomDataTypesValidatorHelper
  class CustomDataTypesValidator
    include RegularExpressionsHelper

    def self.email?(string)
      RegularExpressions::EMAIL.match?(string)
    end
  end
end
