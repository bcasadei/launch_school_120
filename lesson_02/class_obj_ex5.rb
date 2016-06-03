# Continuing with our Person class definition, what does the below print out?

# bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob}"

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def to_s
    name
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}" 
# => output without to_s method: The person's name is: #<Person:0x007ff1840e0358>
# => out with to_s method added to the class: The person's name is: Robert Smith

puts "The person's name is: " + bob.name
# => The person's name is: Robert Smith