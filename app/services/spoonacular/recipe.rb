module Spoonacular
  class Recipe < Base
    attr_accessor :cheap,
                  :cooking_minutes,
                  :dairy_free,
                  :gluten_free,
                  :id,
                  :image,
                  :ingredients,
                  :instructions,
                  :preparation_minutes,
                  :sustainable,
                  :title,
                  :vegan,
                  :vegetarian

    def self.random(query = {})
      response = Request.where('recipes/random', query.merge({ number: 12 }))
      recipes = response.fetch('recipes', []).map { |recipe| Recipe.new(recipe) }
      [ recipes, response[:errors] ]
    end

    def self.find(id)
      response = Request.get("recipes/#{id}/information")
      Recipe.new(response)
    end

    def initialize(args = {})
      super(args)
      self.ingredients = parse_ingredients(args)
      self.instructions = parse_instructions(args)
    end

    def parse_ingredients(args = {})
      args.fetch("extendedIngredients", []).map { |ingredient| Ingredient.new(ingredient) }
    end

    def parse_instructions(args = {})
      instructions = args["analyzedInstructions"]
      instructions.first["steps"].map { |instruction| Instruction.new(instruction) } if instructions
    end
  end
end
