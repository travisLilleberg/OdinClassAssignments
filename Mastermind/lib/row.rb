# frozen_string_literal: true

module Mastermind
  ##
  # Represent a simple 4 item row where each item is 1 of 6 colors.
  class Row
    COLORS = %w[WT RD GN YL BU BK].freeze
    attr_reader :pins

    def initialize(pins = [])
      @pins = valid_pins?(pins) ? pins : []
    end

    def pins=(pins)
      @pins = pins if valid_pins?(pins)
    end

    def to_s
      @pins.to_s
    end

    private

    def valid_pins?(pins)
      return false unless pins.is_a?(Array) && pins.length == 4 && pins.all? { |pin| self.class::COLORS.include?(pin) }

      true
    end
  end
end
