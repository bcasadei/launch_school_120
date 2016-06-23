# 5. If I have the following class:

class Television
  def self.manufacturer
    puts "Samsung"
  end

  def model
    puts "model: 1234567"
  end
end

# What would happen if I called the methods like shown below?

tv = Television.new
# tv.manufacturer # => undefined method `manufacturer' for #<Television:0x007fb90396ad98> (NoMethodError)
tv.model # => model: 1234567

Television.manufacturer # => Samsung
Television.model # => undefined method `model' for Television:Class (NoMethodError)