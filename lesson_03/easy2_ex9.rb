# 9. If we have this class:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def play
    # this method would overide the method in Game
  end

  def rules_of_play
    #rules of play
  end
end

# What would happen if we added a play method to the Bingo class, 
# keeping in mind that there is already a method of this name in 
# the Game class that the Bingo class inherits from.
# A: The play method in the Bingo class would overide the the method in the Game class.