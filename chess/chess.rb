class Board
  attr_accessor :board, :pieces

  def initialize
  	@pieces = []
  end

  def display_board
  end

  def place_a_move(move_hash) #move_hash = {:x, :y, :piece}

  end
end

class Game
	attr_accessor :players, :game_board

	def initialize(player1, player2)
    @game_board = Board.new
    @players = [player1, player2] # first is white, second is black
	end

	def play
		# ask questions start new or from saved file
    #get names for the players
    player = players[0]
		until game_over?
      current_pos, target_pos = player.ask_move #move_array = [f4, f3]
      # until valid_move?(move = player.ask_move)
      game_board.place_a_move(current_pos, target_pos)
      # end
      player = players.next
		end
		#print out win lose message
	end

  def game_over?
    # calculate if game is over
  end

	def save
	end

end

class	Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ask_move
    print "Enter your move: "
    move = gets.chomp
    move_hash #move_hash = {:x, :y, :piece}
  end
end

class Piece
end

class King < Piece
end

if __FILE__ == $PROGRAM_NAME
  sean = Player.new("sean")
  olena = Player.new("olena")
  chess = Game.new
  chess.play(sean, olena)
end

