
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end # initialize in Animal wasn't called because of this initialize method
  # note: if you add super in the initialize method the @name method is inherited
  def dog_name
    "bark! bark! #{@name} bark! bark!" # the @name variable is nil
  end
end
teddy = Dog.new("Teddy")
puts teddy.dog_name
