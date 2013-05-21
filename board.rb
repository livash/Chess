require_relative "piece"

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