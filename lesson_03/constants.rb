# We already saw that constants can be accessed from instance or class 
# methods when defined within a class. But can we reference a constant 
# defined in a different class?
# Not without explicitly calling it

class Dog
  LEGS = 4
end

class Cat
  def legs
    Dog::LEGS # we can access constants by directly calling it through 
              # the Dog class with the namespace resolution operator ::
  end
end

kitty = Cat.new
p kitty.legs # => 4

# Sidenote: you can use :: on classes, modules or constants.