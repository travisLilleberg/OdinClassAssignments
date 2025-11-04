# frozen_string_literal: true

require_relative 'row'

module Mastermind
  ##
  # Represents the board state of the game, stores the secret pattern, and displays previous guesses.
  class Board
    def initialize(secret_row)
      @secret_row = secret_row
      @rows = []
    end

    def guess(row)
      return unless valid?(row)

      response = @secret_row.compare(row.pins)
      @rows << { guess: row, response: response }
      response[:black] == 4
    end

    def count
      @rows.length
    end

    def show
      # system('clear') || system('cls')
      @rows.each { |row| puts "#{row[:guess]} :: #{row[:response]}" }
    end

    private

    def valid?(row)
      unless row.is_a?(Mastermind::Row)
        puts 'Invalid input. Requires a Mastermind::Row object.'
        return false
      end

      true
    end
  end
end
