class Board
  GAME_MAP = []

  attr_accessor :board, :pieces

  def initialize
  	@pieces = []
    @board = []
  end

  def display_board
  end

  def place_a_move(start_pos, target_pos)
    @board[target_pos] = @board[start_pos].dup
    @board[start_pos] = nil
  end
end

class Game
	attr_accessor :players, :game_board

	def initialize(player1, player2)
    @game_board = Board.new
    @players = [player1, player2] # first is white, second is black
	end

	def play
    player = players[0]
		until game_over?
      start_pos, target_pos = player.ask_move #move_array = [f4, f3]
      game_board.place_a_move(start_pos, target_pos)
      player = next_player(player)
		end
		#print out win lose message
	end

  def next_player(player)
    (player == players[0]) ? player[1] : player[0]
  end

  def game_over?
    # TODO: calculate if game is over
    false
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
    # OPTIMIZE: add error checking
    print "Enter your move [f2, f3]: "
    start_pos, target_pos = gets.chomp.split(",")
    [start_pos, target_pos]
  end
end

class Piece
  KING_MOVES = [
    [-1, -1], #[[-1, -1][-2,-2], [-3,-3]]
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
  ]

  QUEEN_MOVES = KING_MOVES.map do |(x, y)|
    # x = move[0]
    # y = move[1]
    temp = []
    1.upto(7) { |i| temp << [x * i, y * i] }
    temp #.flatten(1)
  end.flatten(1)

  def initialize(type)
    @type = type
    @modifier = modifiers_for(type)
  end

  def modifiers_for(type)
    case type
    when :king
      KING_MOVES
    when :queen
      QUEEN_MOVES
    when :bishop
    when :knight
    when :castle
    when :pawn
    else
      raise "Bad type"
    end
  end
end

class King < Piece
  MODIFIER = []
end

class Queen < Piece
  MODIFIER = []
end

class Bishop < Piece
  MODIFIER = []
end

class Knight < Piece
  MODIFIER = []
end

class Castle < Piece
  MODIFIER = []
end

class Pawn < Piece
  MODIFIER = []
end

if __FILE__ == $PROGRAM_NAME
  sean = Player.new("sean")
  olena = Player.new("olena")
  chess = Game.new
  chess.play(sean, olena)
end


does piece a know where it is?
what moves a piece? a player, the piece, the board, the game?




