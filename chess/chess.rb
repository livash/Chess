require_relative "game.rb"

sean = Player.new("sean", :b)
olena = Player.new("olena", :w)
chess = Game.new(sean, olena)
chess.play #(sean, olena)
