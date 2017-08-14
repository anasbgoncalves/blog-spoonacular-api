class Recipe
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

  def self.random(query = {}, clear_cache)
    response = Request.where('recipes/random', query.merge({ number: 12 }), clear_cache)
    response['recipes'].map do |recipe|
      Recipe.new(recipe)
    end
  end

  def self.find(id, clear_cache)
    response = Request.get("recipes/#{id}/information", clear_cache)
    Recipe.new(response)
  end

  def initialize(args = {})
    args.each { |name, value| send("#{name.underscore}=", value) if respond_to?("#{name.underscore}=") }
    self.ingredients = args["extendedIngredients"].map { |ingredient| Ingredient.new(ingredient) }
    self.instructions = args["analyzedInstructions"].first["steps"].map { |instruction| Instruction.new(instruction)} if args["analyzedInstructions"].present?
  end
end
