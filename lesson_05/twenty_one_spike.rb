
class Participant
  def initialize
    @cards =

  end

  def busted?
  end

  def total
    # need to collaborate with Cards for total.
  end
end

class Player < Participant
  def initialize
    super
    @name =
    # what would the data or states of a Player object be?
    # cards? name?
  end

  def hit
  end

  def stay
  end
end

class Dealer < Participant
  def initialize
    super
    # A lot like Player, do we need this class?
    # Yes, needs to contain rules for Dealer play 
    # (e.g. dealer hits unless total is 17)
  end

  def hit
  end

  def stay
  end
end

class Deck
  def initialize
    # data structure for cards
    # 2 dimensional array of cards [['2', 'Clubs'], ['3', 'Clubs']...
  end

  def deal
    # Dealer or Deck?
  end
end

class Card
  def initialize
    # states of card?
    # value of each card (e.g. ['2', 'Clubs'] = 2)
  end
end

class Game

  def display_welcome_message
    puts 'Welcome to 21!'
  end

  def start
    # steps to play game
    display_welcome_message
    # deal_cards
    # show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end
end

Game.new.start
