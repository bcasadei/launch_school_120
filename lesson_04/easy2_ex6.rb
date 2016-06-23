# If I have the following class:
# Which one of these is a class method (if any) and how do you know? 
# A: Class methods are denoted by the self keyword.
# How would you call a class method? 

class Television
  def self.manufacturer # class method
    # method logic
  end

  def model # instance method
    # method logic
  end
end

Television.manufacturer # call class methods by class name and then calling the method



