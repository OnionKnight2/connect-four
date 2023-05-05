# frozen-string-literal: true

# Board class represents a 6x7 board that will be filled with disks.
# Board can be printed out using to_s. In the beginning, board is filled with invisible unicode character.
# #full method checks if every field is field with some kind of disk
# #horizontal_line? method checks if there are 4 same discs together in one row
# #vertical_line? method checks if there are 4 same discs together in one column
# #diagonal_line? method checks if there are 4 same discs together in a diagonal line
# #column_full?(column) method checks if a selected column has all 6 discs
class Board
  INVISIBLE = "\u2063"

  attr_reader :board

  def initialize
    @board = Array.new(6) { Array.new(7) }.map { |row| row.map { nil } }
  end

  # checks if there is no more available fields
  def full?
    board.all? { |row| row.all? { |field| !field.nil? } }
  end

  # Checks for 4 consecutive disks horizontally
  def horizontal_line?
    board.each { |row| return true if row.each_cons(4).any? { |a| a.uniq.count <= 1 && !a[0].nil? } }
    false
  end

  # Checks for 4 consecutive disks vertically
  def vertical_line?
    transposed = board.transpose
    transposed.each { |column| return true if column.compact.each_cons(4).any? { |a| a.uniq.count <= 1 } }
    false
  end

  # Checks for 4 consecutive disks in 6 possible diagonals
  def diagonal_line?
    diagonals = []
    diagonal_one = [board[3][0], board[2][1], board[1][2], board[0][3]]
    diagonal_two = [board[4][0], board[3][1], board[2][2], board[1][3], board[0][4]]
    diagonal_three = [board[5][0], board[4][1], board[3][2], board[2][3], board[1][4], board[0][5]]
    diagonal_four = [board[5][1], board[4][2], board[3][3], board[2][4], board[1][5], board[0][6]]
    diagonal_five = [board[5][2], board[4][3], board[3][4], board[2][5], board[1][6]]
    diagonal_six = [board[5][3], board[4][4], board[3][5], board[2][6]]
    diagonals << diagonal_one << diagonal_two << diagonal_three << diagonal_four << diagonal_five << diagonal_six

    diagonals.each { |diagonal| return true if diagonal.each_cons(4).any? { |a| a.uniq.count <= 1 && !a[0].nil? } }
    false
  end

  # Check if there are 4 consecutive disks anywhere on the board
  def someone_won?
    horizontal_line? || vertical_line? || diagonal_line?
  end

  # Checks if a given column has all 6 possibble disks
  def column_full?(column)
    board.transpose[column].none?(nil)
  end

  # Returns index of the top available field in column
  def empty_field_index(column)
    board.transpose[column].count(nil) - 1
  end

  def to_s
    board.each do |row|
      row.each do |field|
        if field.nil?
          print "#{INVISIBLE}   |"
        else
          print "#{field} |"
        end
      end
      puts "\n\n----------------------------\n\n"
    end
  end
end
