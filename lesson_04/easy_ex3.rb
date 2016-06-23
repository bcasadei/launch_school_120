# 3. In the last question we had a module called Speed which contained a go_fast method. 
# We included this module in the Car class as shown below.

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

# When we called the go_fast method from an instance of the Car class 
# (as shown below) you might have noticed that the string printed when 
# we go fast includes the name of the type of vehicle we are using. 
# How is this done?

porche = Car.new
porche.go_fast
porche.Speed

# A: We call the go_fast method with porche.go_fast and the 
# Car class inherits the go_fast method from the Speed module. 
# We ask self to tell us its .class.
# The string in go_fast handles the interpolation for us.