
class Participant
  def initialize
    # @hand =

  end

  def busted?
  end

  def total
    # need to collaborate with Cards for total.
  end
end

class Player < Participant
  attr_accessor :name

  def initialize
    super
    choose_name
    # what would the data or states of a Player object be?
    # cards? name?
  end

  def choose_name
    loop do
      puts "What's your name?"
      @name = gets.chomp
      break unless name.empty?
      puts 'Sorry, you must enter a value.'
    end
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
    # Yes, needs to contains rules for Dealer play 
    # (e.g. dealer hits unless total is 17)
  end

  def hit
  end

  def stay
  end
end

class Deck
  SUITS = %w(Clubs Diamonds Hearts Spades)
  CARDS = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)

  def initialize
    @deck = CARDS.product(SUITS).shuffle
    p @deck
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
  attr_accessor :player

  def initialize
    @player = Player.new
    @deck = Deck.new
  end

  def display_welcome_message
    puts "Welcome to 21, #{player.name}!"
  end

  def start
    display_welcome_message
    # deal_cards
    # show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end
end

Game.new.start
