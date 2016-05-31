# 2. What is a module? What is its purpose? How do we use them with our classes? 
# Create a module for the class you created in exercise 1 and include it properly.
# A. A module is a collection of behaviors that is useable in other classes via mixins. 
# Modules are another way to achieve polymorphism in Ruby. Modues are also used for namespacing.
# A module is "mixed in" to a class using the include reserved word. 

module Walk
  def walk(pace)
    puts "#{pace}"
  end
end

class GoodDog
  include Walk
end

dave = GoodDog.new
dave.walk("Slow")