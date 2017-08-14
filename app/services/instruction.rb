class Instruction
  attr_accessor :number,
                :step

  def initialize(args = {})
    args.each { |name, value| send("#{name.underscore}=", value) if respond_to?("#{name.underscore}=") }
  end
end
