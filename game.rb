require_relative "board"
require_relative "player"

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

if __FILE__ == $PROGRAM_NAME
  
  player1 = Player.new('Sean', 'w')
  player2 = Player.new('Olena', 'b')
  
  game = Game.new(player1, player2)
  game.players.each { |player| puts "#{player.name} #{player.color}" }
end