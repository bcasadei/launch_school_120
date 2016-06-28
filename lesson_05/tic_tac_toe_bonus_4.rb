require 'pry'

# Tic-Tac-Toe Board class
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]].freeze       # diagonals

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize, MethodLength
  def draw
    puts ''
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end
  # rubocop:enable Metrics/AbcSize, MethodLength

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def find_at_risk_square(line, player)
    if @squares.values_at(*line).count do |x|
      x.instance_variable_get(:@marker) == player
    end == 2
      @squares.select do |k, v|
        line.include?(k) &&
          v.instance_variable_get(:@marker) == Square::INITIAL_MARKER
      end.keys.first
    end
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end
end

# Tic-Tac-Toe Square class
class Square
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

# Human player class
class Human
  attr_accessor :score
  attr_reader :marker, :name

  def initialize(marker)
    @marker = marker
    @score = 0
    set_name
  end

  def set_name
    loop do
      puts "Hi, What's your name?"
      @name = gets.chomp
      break unless @name.empty?
      puts "Sorry, you must enter a value."
    end
  end
end

# Computer player class
class Computer
  attr_accessor :score
  attr_reader :marker, :name

  def initialize(marker)
    @marker = marker
    @score = 0
    set_name
  end

  def set_name
    @name = ['Hal', 'R2D2', 'Chappie', 'Number 5'].sample
  end
end
# class Computer
#   attr_accessor :score
#   attr_reader :marker, :name

#   def initialize
#     @score = 0
#     set_name
#     set_marker
#   end

#   def set_name
#     @name = ['Hal' 'R2D2' 'Chappie' 'Number 5'].sample
#   end

#   def set_marker
#     @marker = ('A'..'Z').to_a.delete(human.marker).sample
#   end

# end

# rubocop:disable Metrics/ClassLength
# Game engine class
class TTTGame
  HUMAN_MARKER = 'X'.freeze
  COMPUTER_MARKER = 'O'.freeze
  FIRST_TO_MOVE = HUMAN_MARKER.freeze
  GAMES_TO_WIN_MATCH = 5

  attr_accessor :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
    @current_player = FIRST_TO_MOVE
  end

  # rubocop:disable Metrics/AbcSize, MethodLength
  def play
    clear
    display_welcome_message

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end

      update_score
      display_result
      display_score
      break if match_won?
      break unless play_again?
      reset
      display_play_again_message
    end

    display_match_winner if match_won?
    display_goodbye_message
  end
  # rubocop:enable Metrics/AbcSize, MethodLength

  private

  def clear
    system 'clear'
  end

  def display_welcome_message
    puts "Hi #{human.name}! Welcome to Tic-Tac-Toe!"
    puts "You're opponent will be #{computer.name} today."
    puts "Win #{GAMES_TO_WIN_MATCH} games to win the match!"
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic-Tac-Toe! Goodbye.'
  end

  def display_board
    puts "#{human.name} is #{human.marker}. #{computer.name} is #{computer.marker}."
    board.draw
    puts ''
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor
    if board.unmarked_keys.length > 1
      board.unmarked_keys.join(', ').insert(-2, 'or ')
    else
      board.unmarked_keys.join(', ')
    end
  end

  def human_moves
    puts "Choose square #{joinor}:"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  # rubocop:disable Metrics/AbcSize, MethodLength
  def computer_moves
    square = nil

    Board::WINNING_LINES.each do |line|
      square = board.find_at_risk_square(line, COMPUTER_MARKER)
      break if square
    end

    unless square
      Board::WINNING_LINES.each do |line|
        square = board.find_at_risk_square(line, HUMAN_MARKER)
        break if square
      end
    end

    unless square
      square = 5 if board.unmarked_keys.include?(5)
    end

    square = board.unmarked_keys.sample unless square

    board[square] = computer.marker
  end
  # rubocop:enable Metrics/AbcSize, MethodLength

  def human_turn?
    @current_player == HUMAN_MARKER
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_player = COMPUTER_MARKER
    elsif @current_player == COMPUTER_MARKER
      computer_moves
      @current_player = HUMAN_MARKER
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "The board is full! It's a tie!"
    end
  end

  def update_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def display_score
    puts '----------------------------------------'
    puts 'MATCH SCORE:'
    puts "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
    puts '----------------------------------------'
  end

  def display_match_winner
    if human.score == 5
      puts "Congratulations #{human.name}! You won the match!"
    elsif computer.score == 5
      puts "Sorry, #{computer.name} won the match!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts 'Sorry, must be y or n.'
    end

    answer == 'y'
  end

  def match_won?
    human.score == GAMES_TO_WIN_MATCH || computer.score == GAMES_TO_WIN_MATCH
  end

  def reset
    board.reset
    @current_player = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end
# rubocop:enable Metrics/ClassLength

game = TTTGame.new
game.play
