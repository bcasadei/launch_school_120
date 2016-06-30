# Tic-Tac-Toe Board class
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]].freeze       # diagonals

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable MethodLength
  def draw
    draw = <<-DRAW

         |     |
      #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}
         |     |
    -----+-----+-----
         |     |
      #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}
         |     |
    -----+-----+-----
         |     |
      #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}
         |     |
    DRAW
    puts draw
  end
  # rubocop:enable MethodLength

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.select { |_, square| square.unmarked? }.keys
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
    if @squares.values_at(*line).count do |sq|
         sq.marker == player
       end == 2
      @squares.select do |k, v|
        line.include?(k) &&
          v.marker == Square::INITIAL_MARKER
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
    marker
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

  def initialize
    @score = 0
    choose_name
    choose_marker
  end

  def choose_name
    loop do
      puts "Hi, What's your name?"
      @name = gets.chomp
      break unless @name.empty?
      puts 'You must enter a value.'
    end
  end

  def choose_marker
    puts "Nice to meet you #{@name}."
    loop do
      puts 'Please choose a marker (A-Z).'
      @marker = gets.chomp.upcase
      break if @marker =~ /[A-Z]/
      puts 'Incorrect value.'
    end
  end
end

# Computer player class
class Computer
  attr_accessor :score
  attr_reader :marker, :name

  def initialize(human_marker)
    @score = 0
    choose_name
    choose_marker(human_marker)
  end

  def choose_name
    @name = ['Hal', 'R2D2', 'Chappie', 'Number 5'].sample
  end

  def choose_marker(human_marker)
    @marker = ('A'..'Z').to_a.delete_if { |l| l == human_marker }.sample
  end
end

# rubocop:disable Metrics/ClassLength
# Game engine class
class TTTGame
  GAMES_TO_WIN_MATCH = 5

  attr_accessor :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new(human.marker)
    @current_player = human.marker
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

  def prompt(message)
    puts "=> #{message}"
  end

  def display_welcome_message
    prompt "Hi #{human.name}! Welcome to Tic-Tac-Toe!"
    prompt "You're opponent will be #{computer.name}."
    prompt "Win #{GAMES_TO_WIN_MATCH} games to win the match!"
    puts ''
  end

  def display_goodbye_message
    prompt 'Thanks for playing Tic-Tac-Toe! Goodbye.'
  end

  def display_board
    prompt "#{human.name} is #{human.marker}."
    prompt "#{computer.name} is #{computer.marker}."
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
    prompt "Choose square #{joinor}:"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      prompt "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def aggressive_move
    Board::WINNING_LINES.each do |line|
      square = board.find_at_risk_square(line, computer.marker)
      return square if square
    end
    nil
  end

  def defensive_move
    Board::WINNING_LINES.each do |line|
      square = board.find_at_risk_square(line, human.marker)
      return square if square
    end
    nil
  end

  def center_move
    5 if board.unmarked_keys.include?(5)
  end

  def random_move
    board.unmarked_keys.sample
  end

  def computer_moves
    square = aggressive_move
    square = defensive_move unless square
    square = center_move unless square
    square = random_move unless square

    board[square] = computer.marker
  end

  def human_turn?
    @current_player == human.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_player = computer.marker
    elsif @current_player == computer.marker
      computer_moves
      @current_player = human.marker
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      prompt "#{human.name} won!"
    when computer.marker
      prompt "#{computer.name} won!"
    else
      prompt "The board is full! It's a tie!"
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
    puts '--------------------------------------------'
    prompt 'MATCH SCORE:'
    prompt "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
    puts '--------------------------------------------'
  end

  def display_match_winner
    if human.score == 5
      prompt "Congratulations #{human.name}! You won the match!"
    elsif computer.score == 5
      prompt "Sorry, #{computer.name} won the match!"
    end
  end

  def play_again?
    answer = nil
    loop do
      prompt 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      prompt 'Sorry, must be y or n.'
    end

    answer == 'y'
  end

  def match_won?
    human.score == GAMES_TO_WIN_MATCH || computer.score == GAMES_TO_WIN_MATCH
  end

  def reset
    board.reset
    @current_player = human.marker
    clear
  end

  def display_play_again_message
    prompt "Let's play again!"
    puts ''
  end
end
# rubocop:enable Metrics/ClassLength

game = TTTGame.new
game.play
