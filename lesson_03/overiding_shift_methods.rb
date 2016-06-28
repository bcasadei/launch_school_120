# You may have seen such an error message before, but dismissed it.
# Read the error message carefully: NoMethodError: undefined method '<<'.
# This should give you a hint that << was actually a method disguised as an operator.

class Player
  attr_accessor :name, :number

  def initialize(name, number)
    @name = name
    @number = number
  end
end

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end
end

cowboys = Team.new("Dallas Cowboys")
emmitt = Player.new("Emmitt Smith", 46)
romo = Player.new("Tony Romo", 9)
bryant = Player.new("Dez Bryant", 88)

cowboys << emmitt
cowboys << romo
cowboys << bryant

p cowboys.members
