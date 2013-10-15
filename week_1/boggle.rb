# Boggle game simulator.  Still need to include functionality for finding words
# with QU included.

class BoggleBoard

  def initialize
    @board = Array.new(4) { Array.new(4) { "_" } }
    @dice = [ ['A', 'A', 'E', 'E', 'G', 'N'],
              ['E', 'L', 'R', 'T', 'T', 'Y'],
              ['A', 'O', 'O', 'T', 'T', 'W'],
              ['A', 'B', 'B', 'J', 'O', 'O'],
              ['E', 'H', 'R', 'T', 'V', 'W'],
              ['C', 'I', 'M', 'O', 'T', 'U'],
              ['D', 'I', 'S', 'T', 'T', 'Y'],
              ['E', 'I', 'O', 'S', 'S', 'T'],
              ['D', 'E', 'L', 'R', 'V', 'Y'],
              ['A', 'C', 'H', 'O', 'P', 'S'],
              ['H', 'I', 'M', 'N', 'Q', 'U'],
              ['E', 'E', 'I', 'N', 'S', 'U'],
              ['E', 'E', 'G', 'H', 'N', 'W'],
              ['A', 'F', 'F', 'K', 'P', 'S'],
              ['H', 'L', 'N', 'N', 'R', 'Z'],
              ['D', 'E', 'I', 'L', 'R', 'X'] ]
    self.shake!
  end

  def shake!
    temp_dice = @dice.shuffle
    4.times do |row|
      @board[row].map! { temp_dice.pop.sample }
    end
  end

  def hard_set!(config)
    @board = config
  end

  def to_s
    string_rows = []
    4.times do |row|
      string_rows << @board[row].join('  ')
      string_rows[row].gsub!(/Q\s?/, 'Qu') if @board[row].include?('Q')
    end
    "\n#{string_rows[0]}\n#{string_rows[1]}\n#{string_rows[2]}\n#{string_rows[3]}"
  end

  def include?(word)
    raise ArgumentError.new('Word must be non-empty string.') unless word.is_a?(String) && word != ""
    @solution = false
    @check = word.upcase
    4.times do |row|
      4.times do |col|
        @letter_pos = 0
        if @board[row][col] == @check[@letter_pos]
          @letter_pos += 1
          letter_search(row, col, [[row, col]], @check[@letter_pos])
        end
      end
    end
    @solution
  end

  private

  def letter_search(r, c, history, letter)
    if letter == nil
      @solution = true
    else
      (-1..1).each do |row_mod|
        (-1..1).each do |col_mod|
          row_i = r + row_mod
          col_i = c + col_mod
          if valid_square?(row_i, col_i, history) && @board[row_i][col_i] == letter
            @letter_pos += 1
            letter_search(row_i, col_i, history + [row_i, col_i], @check[@letter_pos])
          end
        end
      end
      @letter_pos -= 1
    end
  end

  def valid_square?(r, c, check_history)
    !(check_history.include?([r, c]) || r < 0 || r > 3 || c < 0 || c > 3)
  end

end

board = BoggleBoard.new

test_case = [['E', 'B', 'D', 'R'],
             ['E', 'A', 'W', 'T'],
             ['B', 'E', 'R', 'X'],
             ['Y', 'U', 'S', 'J']]

board.hard_set!(test_case)
puts board
p board.include?('bus')  # => true
p board.include?('baby') # => true
p board.include?('bear') # => true
p board.include?('beer') # => true
p board.include?('barn') # => false
p board.include?('rad')  # => true
p board.include?('dear') # => false
p board.include?('year') # => true
p board.include?('beads') # => false
p board.include?('aeea') # => false
p board.include?('beeb') # => true