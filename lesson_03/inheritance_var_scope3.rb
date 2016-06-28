
module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swim

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
teddy.enable_swimming # need to call the enable swimming method to initialize @can_swim
p teddy.swim # => "swimming!"