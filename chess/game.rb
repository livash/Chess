require_relative "board"
require_relative "player"

class Game
	attr_accessor :players, :game_board
  include Conversion

  def initialize(player1, player2)
    @players = [player1, player2] # first is white, second is black
    @game_board = Board.new #(players)
	end

	def play
    player = players[0]
		until game_over?
      success = false
      until success
        game_board.display_board
        start_pos, target_pos = player.ask_move #move_array = [f4, f3]
        success = game_board.place_move_for(player, start_pos, target_pos)
      end
      player = next_player(player)
		end
		#print out win lose message
	end

  def next_player(player)
    (player.eql?(players[0])) ? players[1] : players[0]
  end

  def game_over?
    # TODO: calculate if game is over
    false
  end

	def save
	end
end