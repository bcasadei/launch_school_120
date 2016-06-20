# 7. What is the default thing that Ruby will print to the screen if you call to_s 
# on an object? Where could you go to find out if you want to be sure?
# A: The class name and object id. Run it in IRB

class Person
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Bob")

bob.to_s # => "#<Person:0x007fc5ea8fd0d8>"