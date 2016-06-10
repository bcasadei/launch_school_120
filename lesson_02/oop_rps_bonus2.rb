
class Move
  VALUES = %w(rock paper scissors lizard spock).freeze

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end

  def prompt(message)
    puts "=> #{message}"
  end
end

class Human < Player
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

  def choose
    choice = nil
    loop do
      prompt "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      prompt "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Winner
  WINNERS = {
    'rock' => %w(scissors lizard),
    'paper' => %w(rock spock),
    'scissors' => %w(paper lizard),
    'lizard' => %w(paper spock),
    'spock' => %w(rock scissors)
  }.freeze

  MATCHES_TO_WIN = 5

  def win?(first, second)
    WINNERS[first.to_s].include?(second.to_s)
  end
end

class RPSGame
  attr_accessor :human, :computer, :winner

  def initialize
    @human = Human.new
    @computer = Computer.new
    @winner = Winner.new
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def separator
    puts "----------------------------------------"
  end

  def display_winner
    if winner.win?(human.move, computer.move)
      human.score += 1
      prompt "#{human.name} won!"
    elsif winner.win?(computer.move, human.move)
      computer.score += 1
      prompt "#{computer.name} won!"
    else
      prompt "It's a tie!"
    end
  end

  def match_winner
    separator
    prompt "MATCH SCORE"
    prompt "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}."

    if human.score == Winner::MATCHES_TO_WIN
      prompt "#{human.name} wins the match!"
      separator
    elsif computer.score == Winner::MATCHES_TO_WIN
      prompt "#{computer.name} wins the match!"
      separator
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

  def clear_screen
    system('clear') || system('cls')
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

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def play
    clear_screen
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      match_winner
      break if human.score == Winner::MATCHES_TO_WIN || computer.score == Winner::MATCHES_TO_WIN
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
