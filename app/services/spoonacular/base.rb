module Spoonacular
  class Base
    attr_accessor :errors

    def initialize(args = {})
      args.each do |name, value|
        send("#{name.to_s.underscore}=", value) if respond_to?("#{name.to_s.underscore}=")
      end
    end
  end
end
