class Ingredient
  attr_accessor :id,
                :image,
                :name,
                :amount,
                :unit,
                :original_string

  def initialize(args = {})
    args.each { |name, value| send("#{name.underscore}=", value) if respond_to?("#{name.underscore}=") }
  end
end
