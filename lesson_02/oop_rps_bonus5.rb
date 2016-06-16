# frozen_string_literal: false
class Move
  VALUES = %w(rock paper scissors lizard spock).freeze
  SHORT_VALUES = %w(r p s l sp).freeze

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :score, :history

  def initialize
    @history = Hash.new(0)
    @score = 0
  end

  def update_history
    history[move.to_s] += 1
  end
end

class Human < Player
  attr_accessor :name

  def initialize
    super
    set_name
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def convert_values(value)
    case value
    when 'r'
      'rock'
    when 'p'
      'paper'
    when 's'
      'scissors'
    when 'l'
      'lizard'
    when 'sp'
      'spock'
    end
  end

  def choose
    choice = nil
    loop do
      prompt "Please choose rock, paper, scissors, lizard or spock."
      prompt "Or enter ('r' 'p' 's' 'l' or 'sp')"
      choice = gets.chomp.downcase
      choice = convert_values(choice) if Move::SHORT_VALUES.include?(choice)
      break if Move::VALUES.include?(choice)
      prompt "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end

  private

  def set_name
    n = ''
    loop do
      prompt "What's your name?"
      n = gets.chomp
      break unless n.empty?
      prompt "Sorry, must enter a value."
    end
    self.name = n
  end
end

class Computer < Player
  attr_accessor :name

  def initialize
    super
    set_name
  end

  def choose(player)
    self.move = Move.new(Move::VALUES.sample) if player == {}

    player.each do |k, v|
      adjusted = ((RPSGame::LOSERS[k] * v) + Move::VALUES)
      self.move = Move.new(adjusted.sample)
    end
  end

  private

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end
end

class RPSGame
  attr_accessor :human, :computer

  WINNERS = {
    'rock' => %w(scissors lizard),
    'paper' => %w(rock spock),
    'scissors' => %w(paper lizard),
    'lizard' => %w(paper spock),
    'spock' => %w(rock scissors)
  }.freeze

  LOSERS = {
    'rock' => %w(paper spock),
    'paper' => %w(scissors lizard),
    'scissors' => %w(rock spock),
    'lizard' => %w(rock scissors),
    'spock' => %w(paper lizard)
  }.freeze

  MATCHES_TO_WIN = 5

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def separator
    puts "----------------------------------------"
  end

  def game_winner
    if WINNERS[human.move.to_s].include?(computer.move.to_s)
      human
    elsif WINNERS[computer.move.to_s].include?(human.move.to_s)
      computer
    end
  end

  def display_winner
    if game_winner
      prompt "#{game_winner.name} won!"
    else
      prompt "It's a tie!"
    end
  end

  def update_score
    game_winner.score += 1 if game_winner
  end

  def match_winner
    if human.score == MATCHES_TO_WIN
      human
    elsif computer.score == MATCHES_TO_WIN
      computer
    end
  end

  def display_match_winner
    prompt "#{separator}MATCH SCORE"
    prompt "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}."
    if match_winner
      prompt "#{match_winner.name} wins the match! #{separator}"
    end
  end

  def display_welcome_message
    welcome_prompt = <<-MSG
      ----------------------------------
      Welcome to Rock, Paper, Scissors, Spock!
      ----------------------------------------
      Scissors cuts Paper covers Rock crushes
      Lizard poisons Spock smashes Scissors
      decapitates Lizard eats Paper disproves
      Spock vaporizes Rock crushes Scissors.
      ----------------------------------------
      First to five wins the match!
      ----------------------------------------
      MSG
    prompt(welcome_prompt)
  end

  def display_goodbye_message
    prompt "Thank you for playing Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_moves
    separator
    prompt "#{human.name} chose #{human.move}."
    prompt "#{computer.name} chose #{computer.move}"
  end

  def display_history
    prompt "#{separator}#{human.name}'s choice history is:"
    human.history.each { |k, v| prompt "#{k}: #{v}" }
    prompt "#{separator}#{computer.name}'s choice history is:"
    computer.history.each { |k, v| prompt "#{k}: #{v}" }
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def play_round
    human.choose
    computer.choose(human.history)
    human.update_history
    computer.update_history
    update_score
  end

  def display_round
    display_moves
    display_winner
    display_history
    display_match_winner
  end

  def play_again?
    answer = nil
    loop do
      prompt "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer.downcase)
      prompt "Sorry, must be y or n."
    end

    clear_screen

    answer.downcase == 'y'
  end

  def play
    clear_screen
    display_welcome_message
    loop do
      play_round
      display_round
      break if match_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
