# 5. Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")

p hot_pizza.instance_variables # => [:@name]
p orange.instance_variables # => []

# Pizza has an instance var the @ is used before instance variables
# We can call .instance variable on objects of the class to get all 
# of the instance variables