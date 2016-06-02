=begin
1. Create a superclass called Vehicle for your MyCar class to inherit from and move 
the behavior that isn't specific to the MyCar class to the superclass. Create a constant 
in your MyCar class that stores information about the vehicle that makes it different 
from other types of Vehicles. Then create a new class called MyTruck that inherits from 
your superclass that also has a constant defined that separates it from the MyCar class 
in some way.
=end

module OffRoadable
  def offroad
    puts "Your #{self.year} #{self.model} has 4 wheel drive and can go off-road!"
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles."
  end

  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon of gas."
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

  def to_s
    puts "Your #{year} #{model} is #{color}."
  end

  def age
    puts "Your #{self.model} is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  include OffRoadable
  NUMBER_OF_DOORS = 2
end

celica = MyCar.new(1984, 'white', 'toyota celica')
puts celica

f10 = MyTruck.new(2004, 'silver', 'ford f10')
puts f10

celica.age

Vehicle.number_of_vehicles

f10.offroad

puts "--- MyCar method lookup ---"
puts MyCar.ancestors

puts "--- MyTruck method lookup ---"
puts MyTruck.ancestors

puts "--- Vehicle method lookup ---"
puts Vehicle.ancestors
