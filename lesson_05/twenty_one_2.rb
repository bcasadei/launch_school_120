# Deck class for deck of cards
class Deck
  SUITS = %w(Clubs Diamonds Hearts Spades).freeze
  FACE_VALUE = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace).freeze

  attr_accessor :deck

  def initialize
    @deck = []
    reset
  end

  def reset
    FACE_VALUE.product(SUITS).map { |face, suit| @deck << Card.new(face, suit) }
  end
end

# Card class for individual cards
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

# Participant super class for all participants
class Participant
  attr_accessor :hand

  def initialize
    @hand = []
    @score = 0
  end

  def total_cards
    sum = 0
    hand.each { |card| sum += card.value }
    hand.select { |card| card.face == 'Ace' }.count.times do
      sum -= 10 if sum > Game::WINNING_TOTAL
    end
    sum
  end

  def busted?
    total_cards > Game::WINNING_TOTAL
  end
end

# Player class for human player
class Player < Participant
  attr_accessor :name

  def initialize
    super
    choose_name
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

# Dealer class for computer dealer
class Dealer < Participant
  attr_reader :name

  def initialize
    super
    @name = 'Dealer'
  end
end

# Game engine class
# rubocop:disable Metrics/ClassLength
class Game
  WINNING_TOTAL = 21
  DEALER_STAYS_AT = 17

  attr_accessor :player, :dealer

  def initialize
    @cards = Deck.new
    @player = Player.new
    @dealer = Dealer.new
    @current_player = player
  end

  def clear
    system 'clear'
  end

  def prompt(message)
    puts "==> #{message}"
  end

  def separator
    puts '-----------------------------------------'
  end

  def display_welcome_message
    prompt "Welcome to #{WINNING_TOTAL}, #{player.name}!"
    separator
  end

  # rubocop:disable MethodLength
  def start
    clear
    display_welcome_message
    loop do
      initial_deal
      display_cards
      current_player_turn
      clear
      current_player_turn
      display_result
      break unless play_again?
      new_hand
      clear
    end
  end
  # rubocop:enable MethodLength

  def new_hand
    player.hand.clear
    dealer.hand.clear
  end

  def initial_deal
    @cards.deck.shuffle!
    player.hand.push(@cards.deck.shift(2)).flatten!
    dealer.hand.push(@cards.deck.shift(2)).flatten!
  end

  def format_one_card(arr)
    arr.join(', ')
  end

  def format_multiple_cards(arr)
    arr[-1].insert(0, '& ')
    arr.join(', ')
  end

  def format_cards(cards)
    array = cards.map { |card| "#{card.face} of #{card.suit}" }
    if array.length > 1
      format_multiple_cards(array)
    else
      format_one_card(array)
    end
  end

  def hide_dealer_card
    prompt "#{dealer.name} has: #{format_cards(dealer.hand[0...-1])} and ???"
    prompt "#{player.name} has: #{format_cards(player.hand)} |"\
    " total: #{player.total_cards}"
  end

  # rubocop:disable Metrics/AbcSize
  def show_dealer_card
    prompt "#{dealer.name} has: #{format_cards(dealer.hand)} |"\
    " total: #{dealer.total_cards}"
    prompt "#{player.name} has: #{format_cards(player.hand)} |"\
    " total: #{player.total_cards}"
  end
  # rubocop:enable Metrics/AbcSize

  def display_cards
    if @current_player == player
      hide_dealer_card
    else
      show_dealer_card
    end
    separator
  end

  def hit(participant)
    participant.hand.push(@cards.deck.shift).flatten!
    prompt "#{participant.name} chose to hit."
  end

  # rubocop:disable MethodLength
  def who_won
    if player.busted?
      :player_busted
    elsif dealer.busted?
      :dealer_busted
    elsif dealer.total_cards < player.total_cards
      :player_won
    elsif dealer.total_cards > player.total_cards
      :dealer_won
    else
      :tie
    end
  end
  # rubocop:enable MethodLength

  # rubocop:disable Metrics/AbcSize, MethodLength
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
  # rubocop:enable Metrics/AbcSize, MethodLength

  def current_player_turn
    if @current_player == player
      player_turn
      @current_player = dealer
    else
      dealer_turn
      @current_player = player
    end
  end

  # rubocop:disable Metrics/AbcSize, MethodLength
  def player_turn
    loop do
      answer = nil
      loop do
        break if player.busted?
        prompt "Would you like to hit or stay? ('h' or 's')"
        answer = gets.chomp.downcase
        break if %w(h s).include?(answer)
        prompt "Please enter 'h' or 's' to hit or stay."
      end
      hit(player) if answer == 'h'
      break if player.busted? || answer == 's'
      display_cards
    end
  end
  # rubocop:enable Metrics/AbcSize, MethodLength

  # rubocop:disable Metrics/AbcSize, MethodLength
  def dealer_turn
    loop do
      break if player.busted?

      prompt "#{dealer.name}'s turn…"
      display_cards

      loop do
        break if dealer.busted? || dealer.total_cards >= DEALER_STAYS_AT
        hit(dealer)
        display_cards
      end

      break
    end

    display_cards if player.busted?
  end
  # rubocop:enable Metrics/AbcSize, MethodLength

  def play_again?
    answer = nil
    loop do
      prompt "Do you want to play again? ('y' or 'n')"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
    end
    answer == 'y'
  end
end
# rubocop:enable Metrics/ClassLength

Game.new.start
