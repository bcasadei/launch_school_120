require 'pry'

class Deck
  SUITS = %w(Clubs Diamonds Hearts Spades)
  FACE_VALUE = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)

  attr_accessor :deck

  def initialize
    @deck = []
    reset
  end

  def reset
    FACE_VALUE.product(SUITS).map { |face, suit| @deck << Card.new(face, suit) }
  end
end

class Card
  attr_accessor :face, :suit, :value

  def initialize(face, suit)
    @face = face
    @suit = suit
    set_value
  end

  def set_value
    if face == 'Ace'
      @value = 11
    elsif face.to_i == 0
      @value = 10
    else
      @value = face.to_i
    end
  end
end

class Player
  attr_accessor :name, :hand

  def initialize
    choose_name
    @hand = []
    @score = 0
  end

  def choose_name
    loop do
      puts "What's your name?"
      @name = gets.chomp
      break unless name.empty?
      puts 'Sorry, you must enter a value.'
    end
  end
end

class Dealer
  attr_reader :name, :hand

  def initialize
    @name = "Dealer"
    @hand = []
    @score = 0
  end
end

# Game engine class
class Game
  WINNING_TOTAL = 21.freeze
  DEALER_STAYS_AT = 17.freeze
  HANDS_TO_WIN = 5.freeze

  attr_accessor :player, :dealer

  def initialize
    @cards = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def clear
    system 'clear'
  end

  def prompt(message)
    puts "==> #{message}"
  end

  def separator
    puts '-----------------------------------------'
    puts ''
  end

  def display_welcome_message
    prompt "Welcome to #{WINNING_TOTAL}, #{player.name}!"
    separator
  end

  def start
    clear
    display_welcome_message
    initial_deal
    player_display_cards
    player_turn
    dealer_turn
    dealer_display_cards
    display_result
  end

  def initial_deal
    @cards.deck.shuffle!
    player.hand.push(@cards.deck.shift(2)).flatten!
    dealer.hand.push(@cards.deck.shift(2)).flatten!
  end

  def format_cards(cards)
    array = cards.map { |card| "#{card.face} of #{card.suit}"}
    if array.length > 1
      array[-1].insert(0, '& ')
      array.join(', ')
    else
      array.join(', ')
    end
  end

  def total_cards(hand)
    sum = 0
    hand.each { |card| sum += card.value }
    hand.select { |card| card.face == 'Ace' }.count.times do
      sum -= 10 if sum > WINNING_TOTAL
    end
    return sum
  end

  def player_display_cards
    clear
    prompt "#{dealer.name} has: #{format_cards(dealer.hand[0...-1])} and ???"
    separator
    prompt "#{player.name} has: #{format_cards(player.hand)}"
    prompt "#{player.name}'s total: #{total_cards(player.hand)}"
    separator
  end

  def dealer_display_cards
    clear
    prompt "#{dealer.name} has: #{format_cards(dealer.hand)}"
    prompt "#{dealer.name}'s total: #{total_cards(dealer.hand)}"
    separator
    prompt "#{player.name} has: #{format_cards(player.hand)}"
    prompt "#{player.name}'s total: #{total_cards(player.hand)}"
    separator
  end

  def hit(participant)
    participant.hand.push(@cards.deck.shift).flatten!
    prompt "#{participant.name} chose to hit."
  end

  def who_won
    if busted?(player.hand)
      :player_busted
    elsif busted?(dealer.hand)
      :dealer_busted
    elsif total_cards(dealer.hand) < total_cards(player.hand)
      :player_won
    elsif total_cards(dealer.hand) > total_cards(player.hand)
      :dealer_won
    else
      :tie
    end 
  end

  def display_result
    result = who_won
    case result
    when :player_busted
      prompt "#{player.name} busted! #{dealer.name} wins!"
    when :dealer_busted
      prompt "#{dealer.name} busted! #{player.name} wins!"
    when :player_won
      prompt "#{player.name} wins!"
    when :dealer_won
      prompt "#{dealer.name} wins!"
    when :tie
      prompt "It's a tie!"
    end
  end

  def busted?(hand)
    total_cards(hand) > WINNING_TOTAL
  end

  def player_turn
    loop do
      answer = nil
      loop do
        break if busted?(player.hand)
        prompt "Would you like to hit or stay? ('h' or 's')"
        answer = gets.chomp.downcase
        break if  %w(h s).include?(answer)
        prompt "Please enter 'h' or 's' to hit or stay."
      end
      hit(player) if answer == 'h'
      player_display_cards
      break if busted?(player.hand) || answer == 's'
    end
  end

  def dealer_turn
    prompt "#{dealer.name}'s turn…"
    separator
    dealer_display_cards
    loop do
      break if busted?(dealer.hand) || total_cards(dealer.hand) >= DEALER_STAYS_AT
      hit(dealer)
    end
  end
end

Game.new.start
