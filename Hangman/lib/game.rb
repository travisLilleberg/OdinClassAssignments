# frozen_string_literal: true

module Hangman
  ##
  # Takes user input and displays game status.
  class Game
    def initialize(game_state, io = $stdout)
      @game_state = game_state
      @io = io
    end

    # rubocop:disable Metrics/MethodLength
    def go
      until @game_state.end_of_game?
        @game_state.display

        unless (letter = user_input)
          @io.puts "\nInvalid input. Please enter a single letter (or save)."
          sleep(1)
          next
        end

        if letter == 'save'
          @game_state.save
        else
          @game_state.guess(letter)
        end
      end

      end_of_game_display(@game_state.win?)
    end
    # rubocop:enable Metrics/MethodLength

    private

    def end_of_game_display(win)
      @io.puts "\n\n-----------------------------------------------\n"
      if win
        @io.puts "\n Y O U   W I N"
        @game_state.display
      else
        @io.puts "\n Y O U   L O S E"
        @io.puts "\nThe secret word was \"#{@game_state.secret_word}\""
      end
    end

    def user_input
      @io.puts "\nGuess a letter (or type 'save' to save): "
      letter = gets.chomp.downcase
      return letter if letter == 'save'
      return false unless /^[a-z]{1}$/.match?(letter)

      letter
    end
  end
end
