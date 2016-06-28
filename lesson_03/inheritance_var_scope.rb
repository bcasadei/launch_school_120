# Instance Variables
# First, we'll look at how sub-classing affects instance variables.

class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def dog_name
    "bark! bark! #{@name} bark! bark!" # instance variables are inherited by subclasses
  end
end
teddy = Dog.new("Teddy")
puts teddy.dog_name

