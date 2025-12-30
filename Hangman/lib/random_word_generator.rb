# frozen_string_literal: true

module Hangman
  ##
  # Picks a random word from assets/words.txt that's an appropriate length.
  module RandomWordGenerator
    def self.get_word(target = 'assets/words.txt')
      f = File.open(target)
      lines = f.readlines.map(&:chomp)
      word = ''
      word = lines[rand(0..lines.length)] until word.length > 4 && word.length < 13
      f.close

      word
    end
  end
end
