# does piece a know where it is?
# what moves a piece? a player, the piece, the board, the game?

require_relative "game"

sean = Player.new("sean")
olena = Player.new("olena")
chess = Game.new
chess.play(sean, olena)
