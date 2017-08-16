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
    response, status = Request.where('recipes/random', query.merge({ number: 12 }), clear_cache)
    if status == 200 && response['status'] != 'failure'
      response['recipes'].map { |recipe| Recipe.new(recipe) }
    else
      { error: response["message"], status: status }
    end
  end

  def self.find(id, clear_cache)
    response, status = Request.get("recipes/#{id}/information", clear_cache)
    if status == 200 && response['status'] != 'failure'
      Recipe.new(response)
    else
      { error: response["message"], status: status }
    end
  end

  def initialize(args = {})
    args.each { |name, value| send("#{name.underscore}=", value) if respond_to?("#{name.underscore}=") }
    self.ingredients = args["extendedIngredients"].map { |ingredient| Ingredient.new(ingredient) }
    self.instructions = args["analyzedInstructions"].first["steps"].map { |instruction| Instruction.new(instruction)} if args["analyzedInstructions"].present?
  end
end
