class Board
  GAME_MAP = []

  attr_accessor :board, :pieces

  def initialize
  	@pieces = []
    @board = []
  end

  def generate_pieces
    [:black, :white].each do |color|
  end

  def display_board
  end

  def place_a_move(start_pos, target_pos)
    @board[target_pos] = @board[start_pos]
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
      succcess = false
      until success
        start_pos, target_pos = player.ask_move #move_array = [f4, f3]
        success = game_board.place_a_move(start_pos, target_pos)
      end
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
  DIAGONAL_MOVES = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  ORTHOGONAL_MOVES = [[-1, 0], [0, -1], [0, 1], [1, 0]]
end

class King < Piece
  def possible_moves
    DIAGONAL_MOVES + ORTHOGONAL_MOVES
  end
end

class Queen < Piece
  def possible_moves
    KING_MOVES.map do |(x, y)|
      expand_arr = []
      1.upto(7) { |i| expand_arr << [x * i, y * i] }
      expand_arr
    end.flatten(1)
  end
end

class Bishop < Piece

  def possible_moves
    DIAGONAL_MOVES.map do |(x, y)|
      expand_arr = []
      1.upto(7) { |i| expand_arr << [x * i, y * i] }
      expand_arr
    end.flatten(1)
  end
end

class Knight < Piece
  def possible_moves
    [
      [-2, -1],
      [-2,  1],
      [-1, -2],
      [-1,  2],
      [ 1, -2],
      [ 1,  2],
      [ 2, -1],
      [ 2,  1]
    ]
  end
end

class Castle < Piece
  def possible_moves
    ORTHOGONAL_MOVES.map do |(x, y)|
      expand_arr = []
      1.upto(7) { |i| expand_arr << [x * i, y * i] }
      expand_arr
    end.flatten(1)
  end
end

class Pawn < Piece
  def possible_moves
    # TODO: add checking
    [0, 1]
  end
end

if __FILE__ == $PROGRAM_NAME
  sean = Player.new("sean")
  olena = Player.new("olena")
  chess = Game.new
  chess.play(sean, olena)
end


does piece a know where it is?
what moves a piece? a player, the piece, the board, the game?




