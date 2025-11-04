# frozen_string_literal: true

require_relative 'row'
require_relative 'secret_row'
require_relative 'board'

module Mastermind
  ##
  # Manages the user inputs and displays.
  class Game
    def initialize(board, total_guesses = 12)
      @board = board
      @total_guesses = total_guesses
    end

    # rubocop:disable Metrics/MethodLength
    def go
      until @board.count >= @total_guesses
        unless (guess = user_input)
          puts "\nInvalid input. Please try again."
          next
        end

        puts "\n"
        if @board.guess(guess)
          puts '============= YOU WON =============='
          puts guess
          return
        end

        puts '---------- BOARD STATE -----------'
        @board.show
      end

      puts "\nSorry! You only get #{@total_guesses} guesses. Try again!"
    end
    # rubocop:enable Metrics/MethodLength

    def user_input
      inputs = []
      puts "\nValid Inputs: white (wt), red (rd), green (gn), yellow (yl), blue (bu), black (bk)"
      (1..4).each do |i|
        puts "Color ##{i}?"
        inputs << translate(gets.chomp)
      end

      row = Mastermind::Row.new(inputs)
      row.pins.empty? ? false : row
    end

    private

    # rubocop:disable Metrics/MethodLength
    def translate(color_input)
      case color_input.downcase
      when /^w(t|(hite))?$/
        'WT'
      when /^r(d|(ed))?$/
        'RD'
      when /^g(n|(reen))?$/
        'GN'
      when /^y(l|(ellow))?$/
        'YL'
      when /^b(u|(lue))$/
        'BU'
      when /^b(k|(lack))$/
        'BK'
      else
        # The validator on Row will pick this up.
        'BAD'
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
