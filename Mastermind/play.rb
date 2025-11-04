# frozen_string_literal: true

require_relative 'lib/secret_row'
require_relative 'lib/board'
require_relative 'lib/game'

r = Mastermind::SecretRow.generate_random
g = Mastermind::Game.new(Mastermind::Board.new(r))

puts "ANSWER: #{r}" if ARGV.pop == '--debug'
g.go
