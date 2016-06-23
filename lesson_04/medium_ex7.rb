# 7. How could you change the method name below so that the method name 
 # is more clear and less repetitive.

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.light_information # self.information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end
