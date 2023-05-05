# frozen-string-literal: true

require_relative 'player'
require_relative 'board'

# Game class will represent a game being played. It holds two players and a board.
class Game
  WHITE = "\u26aa"
  BLACK = "\u26ab"

  attr_reader :board, :player_one, :player_two

  def initialize
    @board = Board.new
    @player_one = Player.new(WHITE, true)
    @player_two = Player.new(BLACK)
  end

  # Main class for the game to be played. Until the game is over, same steps are being repeated.
  def play
    intro

    board.to_s

    until board.full? || board.someone_won?
      play_move(whose_turn, get_user_move(whose_turn))
      change_turn
      board.to_s
    end

    puts "\nDRAW!" if board.full?
    change_turn
    puts "Congratulations, #{whose_turn.name} #{whose_turn.disk}" if board.someone_won?
  end

  # Writes an intro that gets users' information
  def intro
    puts "HELLO, WELCOME TO CONNECT 4\n\n"
    puts 'Player 1, please enter your name: '
    player_one.name = gets.chomp
    puts "\nPlayer 2, please enter your name: "
    player_two.name = gets.chomp

    puts "\n#{player_one.name} has #{player_one.disk} disks and #{player_two.name} has #{player_two.disk} disks\n\n"
  end

  # Gets one user move, that is a column where the disk should be put
  def get_user_move(player)
    puts "#{player.name}, please enter your move: "
    move = gets.chomp
    until valid_move?(move) && in_bounds?(move)
      puts "#{player.name}, please enter your move: "
      move = gets.chomp
    end
    move.to_i
  end

  # Checks if the inputed column is a number between 0 and 6
  def valid_move?(move)
    move.between?('0', '6') && move.length.eql?(1)
  end

  # Checks if the inputed column has available fields
  def in_bounds?(move)
    !board.column_full?(move.to_i)
  end

  # Returns a player who should play his move next
  def whose_turn
    player_one.turn ? player_one : player_two
  end

  def change_turn
    if player_one.turn
      player_one.turn = false
      player_two.turn = true
    else
      player_one.turn = true
      player_two.turn = false
    end
  end

  # Represents one player's move. Put appropriate disk to user's inputed column
  def play_move(player, column)
    row = board.empty_field_index(column)
    board.board[row][column] = player.disk unless board.column_full?(column)
  end
end
