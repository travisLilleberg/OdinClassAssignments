# frozen_string_literal: true

##
# Represents the board state for the tic tac toe game.
class Board
  def initialize
    @board = Array.new(3).fill { Array.new(3).fill(' ') }
  end

  def mark(value, row, col)
    if win?
      puts "Game over! You're done!"
      return
    end

    return false unless %w[X 0].include?(value) && @board[row][col] == ' '

    @board[row][col] = value
    true
  end

  def show
    puts '-------------'
    @board.each do |row|
      puts "| #{row.join(' | ')} |"
      puts '-------------'
    end
  end

  # rubocop:disable Metrics/MethodLength
  def win?
    marks = @board.flatten

    if (val = check_columns?(marks))
      return val
    end

    if (val = check_rows?(marks))
      return val
    end

    if (val = check_diagonals?(marks))
      return val
    end

    false
  end
  # rubocop:enable Metrics/MethodLength

  def check_columns?(marks)
    (0..2).each do |i|
      next if marks[i] == ' '
      return marks[i] if check_combo?(marks, [i, i + 3, i + 6])
    end

    false
  end

  def check_rows?(marks)
    [0, 3, 6].each do |i|
      next if marks[i] == ' '
      return marks[i] if check_combo?(marks, [i, i + 1, i + 2])
    end

    false
  end

  def check_diagonals?(marks)
    return marks[4] if (marks[4] != ' ') && (check_combo?(marks, [0, 4, 8]) || check_combo?(marks, [2, 4, 6]))

    false
  end

  def check_combo?(values, i_to_check)
    i_to_check.reduce([]) { |arr, i| arr << values[i] }.uniq.length == 1
  end
end
