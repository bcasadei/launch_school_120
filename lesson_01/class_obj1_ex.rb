# Create a class called MyCar. When you initialize a new instance or 
# object of the class, allow the user to define some instance variables 
# that tell us the year, color, and model of the car. Create an instance 
# variable that is set to 0 during instantiation of the object to track 
# the current speed of the car as well. Create instance methods that allow 
# the car to speed up, brake, and shut the car off.

class MyCar
  attr_accessor :color
  attr_reader :year, :model

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @current_speed = 0
  end

  def accelerate(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the gas and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your #{self.year} #{self.model} has been painted #{self.color}"
  end
end

celica = MyCar.new(1984, 'white', 'toyota celica')
celica.spray_paint('green')
celica.accelerate(20)
celica.current_speed
celica.accelerate(20)
celica.current_speed
celica.brake(20)
celica.current_speed
celica.brake(20)
celica.current_speed
celica.shut_down
celica.current_speed

