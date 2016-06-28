
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person) # the > method can be overiden to compare the age variable
    age > other_person.age
  end
end

bob = Person.new('Bob', 49)
kim = Person.new('Kim', 33)

# this works without overiding the > method
puts "bob is older than kim" if bob.age > kim.age # => bob is older than kim

puts "bob is older than kim" if bob > kim # => bob is older than kim