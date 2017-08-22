module Spoonacular
  class Recipe < Base
    attr_accessor :aggregate_likes,
                  :dairy_free,
                  :gluten_free,
                  :id,
                  :image,
                  :ingredients,
                  :instructions,
                  :ready_in_minutes,
                  :title,
                  :vegan,
                  :vegetarian

    MAX_LIMIT = 12

    def self.random(query = {})
      response = Request.where('recipes/random', query.merge({ number: MAX_LIMIT }))
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
      if instructions
        steps = instructions.first.fetch("steps", [])
        steps.map { |instruction| Instruction.new(instruction) }
      end
    end
  end
end
