# frozen_string_literal: true

require_relative 'game_serializer'

module Hangman
  ##
  # Stores state of the game including correct and incorrect guesses and turns left.
  class GameState
    include Hangman::GameSerializer

    attr_reader :secret_word
    # After loading serialized file, we have to reset io.
    attr_writer :io

    def initialize(secret_word, max_turns = 6, io = $stdout)
      @secret_word = secret_word.downcase
      @secret_letters = Set.new(@secret_word.chars)
      @correct_guesses = Set.new
      @incorrect_guesses = Set.new
      @turns_left = max_turns
      @io = io
    end

    def guess(letter)
      letter.downcase!
      return nil if (@correct_guesses | @incorrect_guesses).include?(letter)

      success = process_guess(letter)

      @turns_left -= 1 unless success

      success
    end

    def end_of_game?
      win? || @turns_left <= 0
    end

    def win?
      @secret_letters.empty?
    end

    def display
      @io.puts "\n-----------------------------------------------\n\n"
      secret_word = @secret_word.dup
      @io.print 'Hangman: '
      secret_word.each_char do |letter|
        @io.print "#{@correct_guesses.include?(letter) ? letter : '_'} "
      end
      @io.puts "\n\nOther Guesses: #{@incorrect_guesses.join(' ')}"
      @io.puts "\nTurns left: #{@turns_left}"
    end

    private

    def process_guess(letter)
      if (success = @secret_letters.include?(letter))
        @correct_guesses << letter
        @secret_letters.delete(letter)
      else
        @incorrect_guesses << letter
      end

      success
    end
  end
end
