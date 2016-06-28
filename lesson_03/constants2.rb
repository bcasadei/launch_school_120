# Unlike instance methods or instance variables, constants are not evaluated at runtime, 
# so their lexical scope - or, where they are used in the code - is very important. 
# In this case, the line "Changing #{WHEELS} tires." is in the Maintenance module, 
# which is where Ruby will look for the WHEELS constant. Even though we call the 
# change_tires method from the a_car object, Ruby is not able to find the constant.
# We can explicitly call the WHEELS variable with Vehicle::WHEELS or Car:: Wheesl to fix this.

module Maintenance
  def change_tires
    # "Changing #{Vehicle::WHEELS} tires." # this will fix the issue
    "Changing #{WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance

  def self.wheels
    WHEELS
  end

  def wheels
    WHEELS
  end
end

p Car.wheels # => 4

a_car = Car.new
p a_car.wheels # => 4
p a_car.change_tires # => uninitialized constant Maintenance::WHEELS (NameError)
