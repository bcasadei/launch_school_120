# 6. What could we add to the class below to access the instance variable @volume?
# A getter method or attr_accessor

# class Cube
#   attr_accessor :volume

#   def initialize(volume)
#     @volume = volume
#   end
# end

# big_cube = Cube.new(5000)
# p big_cube.volume

# or
class Cube
  def initialize(volume)
    @volume = volume
  end

  def get_volume
    @volume
  end
end

big_cube = Cube.new(5000)
p big_cube.get_volume