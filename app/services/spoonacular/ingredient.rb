module Spoonacular
  class Ingredient < Base
    attr_accessor :id,
                  :image,
                  :name,
                  :amount,
                  :unit,
                  :original_string
  end
end
