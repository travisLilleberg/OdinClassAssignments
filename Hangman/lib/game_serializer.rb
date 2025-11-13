# frozen_string_literal: true

module Hangman
  ##
  # Saves and loads a Hangman::GameState object.
  module GameSerializer
    def save(target = './saves/save.mld', io = $stdout)
      if @io
        tmp_io = @io
        @io = nil
      end

      File.write(target, Marshal.dump(self))

      @io = tmp_io || io
      @io.puts "\n\n Saved!"

      sleep(1)
    end

    # Using JSON instead of Marshal will reveal the secret word in the save file.
    # This is trusted data, so Marshal is fine.
    # rubocop:disable Security/MarshalLoad
    def self.load(file = './saves/save.mld')
      Marshal.load(File.read(file))
    end
    # rubocop:enable Security/MarshalLoad
  end
end
