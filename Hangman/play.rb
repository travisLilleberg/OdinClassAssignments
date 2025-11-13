# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/game_state'
require_relative 'lib/random_word_generator'
require_relative 'lib/game_serializer'

if File.exist?('./saves/save.mld')
  puts 'Load previous game? (yn)'
  yn = $stdin.gets.chomp
else
  yn = 'no'
end

if /^y(es)?$/.match?(yn)
  game_state = Hangman::GameSerializer.load
  secret_word = game_state.secret_word
  game_state.io = $stdout
else
  secret_word = Hangman::RandomWordGenerator.get_word
  game_state = Hangman::GameState.new(secret_word)
end

puts "\nANSWER: #{secret_word}\n" if ARGV.pop == '--debug'
Hangman::Game.new(game_state).go
