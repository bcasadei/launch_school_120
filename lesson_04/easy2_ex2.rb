# 2. We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices # Ruby looks for the method choice here first.
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of the following:

trip = RoadTrip.new
p trip.predict_the_future # => "You will romp in Rome" (Answer will vary.)

# Every time Ruby tries to resolve a method name, it will start with the methods 
# defined on the class you are calling. So even though the call to choices happens 
# in a method defined in Oracle, Ruby will first look for a definition of choices 
# in RoadTrip before falling back to Oracle if it does not find choices defined 
# in RoadTrip. 