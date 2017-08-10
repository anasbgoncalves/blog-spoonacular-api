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

  def self.random(query = {})
    response = Request.where('recipes/random', query.merge({ number: 12 }))
    response['recipes'].map do |recipe|
      Recipe.new(recipe)
    end
  end

  def self.find(id)
    response = Request.get(id)
  end

  def initialize(args = {})
    args.each { |name, value| send("#{name.underscore}=", value) if respond_to?("#{name.underscore}=") }
  end
end
