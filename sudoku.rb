# Basic Sudoku solver.  Uses basic row, column, and box checks to solve board.
# Input is a string of numbers where 0's represent empty spots.  Solver stops
# iterating over board when there are no more empty spaces or the board remains
# unchanged between full board sweeps (this means guessing is required to solve
# board).

class Sudoku
  CHECK_VALUES = (1..9).to_a

  def initialize(board_string)
    @board_string = board_string
    initialize_board
  end

  def initialize_board
    @grid = []
    9.times do |row|
      @grid << @board_string.slice!(0..8).split(//)
      @grid[row].map! { |value| value.to_i }
    end
  end

  def solve!
    solved = false
    until solved
      input = Marshal.load(Marshal.dump(@grid))
      9.times do |row|
        9.times do |col|
          if @grid[row][col] == 0
            checked = CHECK_VALUES.dup
            checked -= box_check(row, col)
            checked -= column_check(col)
            checked -= row_check(row)
            if checked.length == 1
              @grid[row][col] = checked[0]
            end
          end
        end
      end

      if @grid.flatten.include?(0) != true
        solved = true
        board
      elsif input == @grid
        board
        puts "Board could not be solved without guessing."
        break
      end
    end
  end


  def box_check(row, col)
    coord = [row, col]
    box_corner = []
    case
    when (0..2).include?(coord[0]) && (0..2).include?(coord[1])
      box_corner = [0, 0]
    when (0..2).include?(coord[0]) && (3..5).include?(coord[1])
      box_corner = [0, 3]
    when (0..2).include?(coord[0]) && (6..8).include?(coord[1])
      box_corner = [0, 6]
    when (3..5).include?(coord[0]) && (0..2).include?(coord[1])
      box_corner = [3, 0]
    when (3..5).include?(coord[0]) && (3..5).include?(coord[1])
      box_corner = [3, 3]
    when (3..5).include?(coord[0]) && (6..8).include?(coord[1])
      box_corner = [3, 6]
    when (6..8).include?(coord[0]) && (0..2).include?(coord[1])
      box_corner = [6, 0]
    when (6..8).include?(coord[0]) && (3..5).include?(coord[1])
      box_corner = [6, 3]
    when (6..8).include?(coord[0]) && (6..8).include?(coord[1])
      box_corner = [6, 6]
    end

    slice_box(box_corner)

  end

  def slice_box(corner_coordinates)
    r = corner_coordinates[0]
    c = corner_coordinates[1]
    output = []

    r.upto(r + 2) {|row| output << @grid[row].slice(c, 3)}

    output.flatten!
  end

  def row_check(row)
    @grid[row]
  end

  def column_check(col)
    @grid.transpose[col]
  end

  def board
    formatted_board = []
    empty = [" ", " ", " | ", " ", " ", " | ", " ", " ", " "]
    @grid.each {|row| formatted_board << row.zip(empty).flatten.join}

    puts "- - - - - - - - - - -"
    puts formatted_board[0]
    puts formatted_board[1]
    puts formatted_board[2]
    puts "- - - - - - - - - - -"
    puts formatted_board[3]
    puts formatted_board[4]
    puts formatted_board[5]
    puts "- - - - - - - - - - -"
    puts formatted_board[6]
    puts formatted_board[7]
    puts formatted_board[8]
    puts "- - - - - - - - - - -"
  end
end

board_string = '105802000090076405200400819019007306762083090000061050007600030430020501600308900'
game = Sudoku.new(board_string)
puts "Unsolved board:"
game.board
puts "Result of solver:"
game.solve!