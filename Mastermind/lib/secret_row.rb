# frozen_string_literal: true

require_relative 'row'

module Mastermind
  ##
  # Represents the secret row that the players attempt to guess.
  class SecretRow < Row
    def self.generate_random
      random_pins = []
      4.times do
        random_pins << self::COLORS.sample(1).pop
      end
      new(random_pins)
    end

    def compare(pins)
      # Have to do all black pins before white pins, as black takes precedence.
      white_pins(*black_pins(pins))
    end

    private

    # Look for black pins (matching color && position).
    def black_pins(pins)
      secret_pins = @pins.dup
      guess_pins = pins.dup
      response_pins = { black: 0, white: 0 }

      guess_pins.each_with_index do |pin, index|
        next unless secret_pins[index] == pin

        response_pins[:black] += 1
        # Remove matched values so we don't hit them again.
        secret_pins[index] = nil
        guess_pins[index] = nil
      end

      [secret_pins, guess_pins.compact, response_pins]
    end

    # Look for white pins (matching color only).
    def white_pins(secret_pins, guess_pins, response_pins)
      guess_pins.each do |pin|
        target_index = secret_pins.find_index(pin)
        unless target_index.nil?
          response_pins[:white] += 1
          secret_pins[target_index] = nil
        end
      end

      response_pins
    end
  end
end
