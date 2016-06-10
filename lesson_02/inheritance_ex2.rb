# Let's create a few more methods for our Dog class.
# Create a new class called Cat, which can do everything a dog can, except swim or 
# fetch. Assume the methods do the exact same thing. Hint: don't just copy and paste 
# all methods in Dog into Cat; try to come up with some class hierarchy.

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

puts pete.run                # => "running!"
# pete.speak              # => NoMethodError

puts kitty.run               # => "running!"
puts kitty.speak             # => "meow!"
# kitty.fetch             # => NoMethodError

puts dave.speak              # => "bark!"

puts bud.run                 # => "running!"
puts bud.swim                # => "can't swim!"

puts "-------- Bulldog method lookup -------- "
puts Bulldog.ancestors
