# 7. If we have a class such as the one below:
# Explain what the @@cats_count variable does and how it works.
# A: @@cats_count keeps track of how many instances have been created from the Cats class.
# When a new object is created the initialize method increments 1 to the variable.

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# What code would you need to write to test your theory?
cat1 = Cat.new("Siamese")
p Cat.cats_count # => 1
cat2 = Cat.new("Hairless")
p Cat.cats_count # => 2





