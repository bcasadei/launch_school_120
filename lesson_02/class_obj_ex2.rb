# Modify the class definition from above to facilitate the following methods. 
# Note that there is no name= setter method now.
# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'


class Person
  attr_accessor :first_name, :last_name

  def initialize(f, l="")
    self.first_name = f
    self.last_name = l
  end

  def name
    name = self.first_name + " " + self.last_name
  end
end

bob = Person.new('Robert')
puts bob.name
puts bob.first_name
puts bob.last_name
bob.last_name = 'Smith'
puts bob.last_name
puts bob.name   