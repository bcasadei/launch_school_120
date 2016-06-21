# When objects are created they are a separate realization of a particular class.
# Given the class below, how do we create two different instances of this class, 
# both with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

angry_cat1 = AngryCat.new(10, "Tabby")
angry_cat2 = AngryCat.new(15, "Fuzzy")

angry_cat1.name
angry_cat1.age

angry_cat2.name
angry_cat2.age