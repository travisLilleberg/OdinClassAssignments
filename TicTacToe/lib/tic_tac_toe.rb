# frozen_string_literal: true

##
# Manages the user interaction for the TicTacToe game.
class TicTacToe
  def initialize(board)
    @board = board
    @turn = %w[X 0].shuffle.pop
    go
  end

  def next_player
    @turn = @turn == 'X' ? '0' : 'X'
  end

  # rubocop:disable Metrics/MethodLength
  # This is a cohesive chunk of code. Breaking it up would be needlessly complicated.
  def go
    until @board.win?
      puts
      @board.show

      next unless (input = user_input)

      unless @board.mark(@turn, input[0], input[1])
        puts "\nInvalid input. Square is taken."
        next
      end

      if @board.win?
        puts "\n#{@turn} wins!"
        @board.show
      end

      next_player
    end
  end
  # rubocop:enable Metrics/MethodLength

  def user_input
    puts "Player #{@turn} is up."

    puts 'Row? -- (t)op, (m)iddle, (b)ottom'
    row = translate(gets.chomp)

    puts 'Column? -- (l)eft, (c)enter, (r)ight)'
    col = translate(gets.chomp)

    unless row && col
      puts "\nInvalid input, try 't', 'm', or 'b' for rows and 'l', 'c', or 'r' for columns."
      return false
    end

    [row, col]
  end

  def translate(position)
    case position
    when /(t)|(top)|(l)|(left)/
      0
    when /(c)|(center)|(m)|(middle)/
      1
    when /(b)|(bottom)|(r)|(right)/
      2
    else
      false
    end
  end
end
