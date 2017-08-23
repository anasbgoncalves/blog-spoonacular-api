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
    CACHE_DEFAULTS = { expires_in: 7.days, force: false }

    def self.random(query = {}, clear_cache)
      cache = CACHE_DEFAULTS.merge({ force: clear_cache })
      response = Request.where('recipes/random', cache, query.merge({ number: MAX_LIMIT }))
      recipes = response.fetch('recipes', []).map { |recipe| Recipe.new(recipe) }
      [ recipes, response[:errors] ]
    end

    def self.find(id)
      response = Request.get("recipes/#{id}/information", CACHE_DEFAULTS)
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
      instructions = args.fetch("analyzedInstructions", [])
      if instructions.present?
        steps = instructions.first.fetch("steps", [])
        steps.map { |instruction| Instruction.new(instruction) }
      else
        []
      end
    end
  end
end
