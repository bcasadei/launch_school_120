
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels # => 2
p Vehicle.wheels # => 2 not 4 the sub class overrides the class variable
# For this reason, avoid using class variables when working with inheritance. 
# In fact, some Rubyists would go as far as recommending avoiding class variables altogether. 
# The solution is usually to use class instance variables, but that's a topic we aren't ready 
# to talk about yet.