=begin
Given the following code...
bob = Person.new
bob.hi
And the corresponding error message...
NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
from (irb):8
from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

A. The method hi is private. Make it a public method by moving it above 
the reserve word `private`.
=end

class Person
  def hi
    puts "Hi!"
  end

  private

end

bob = Person.new
bob.hi