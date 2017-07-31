class Recipe
  attr_accessor :cheap,
               :cooking_minutes,
               :dairy_free,
               :gluten_free,
               :image,
               :ingredients,
               :instructions,
               :preparation_minutes,
               :sustainable,
               :title,
               :vegan,
               :vegetarian

  def self.random
    response = Request.where('recipes/random', { number: 10 })
    response['recipes'].map do |recipe|
      Recipe.new(recipe)
    end
  end

  def initialize(args = {})
    args.each { |name, value| send("#{name.underscore}=", value) if respond_to?("#{name.underscore}=") }
  end
end
