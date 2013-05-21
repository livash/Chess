require_relative "piece"

class Board
  # GAME_MAP = []

  attr_accessor :board, :pieces

  def initialize
    # @pieces = generate_pieces
    @board = generate_board
    # commit_pieces_to_board
  end

  def generate_board
    board = []
    8.times do |rows|
      row = []
      8.times do |row_element|
        row << "__"
      end
      board << row
    end

    board[0][0] = "Ca"
    board[0][1] = "Kn"
    board[0][2] = "Bi"
    board[0][3] = "Ki"
    board[0][4] = "Qu"
    board[0][5] = "Bi"
    board[0][6] = "Kn"
    board[0][7] = "Ca"
    board[1].map! { |tile| tile = "Pa"}

    board[7][0] = "Ca"
    board[7][1] = "Kn"
    board[7][2] = "Bi"
    board[7][3] = "Ki"
    board[7][4] = "Qu"
    board[7][5] = "Bi"
    board[7][6] = "Kn"
    board[7][7] = "Ca"
    board[6].map! { |tile| tile = "Pa"}

    board
  end

  # def generate_pieces
  #   pieces = {}
  #   pieces[:white] = []
  #   pieces[:white][0] = %w[Ca Kn Bi Qu Ki Bi Kn Ca]
  #   pieces[:white][1] = %w[Pa Pa Pa Pa Pa Pa Pa Pa]
  #
  #   pieces[:black] = []
  #   pieces[:black][0] = %w[Ca Kn Bi Ki Qu Bi Kn Ca]
  #   pieces[:black][1] = %w[Pa Pa Pa Pa Pa Pa Pa Pa]
  # end
  #
  # def commit_pieces_to_board
  #
  # end

  def display_board
    puts
    puts "  a  b  c  d  e  f  g  h"
    puts "  0  1  2  3  4  5  6  7"
    @board.each_with_index do |row, idx|
      puts "#{idx} #{row.join(" ")}"
    end
  end

  def place_a_move(start_pos, target_pos)
    y_start,x_start = start_pos
    y_targ, x_targ = target_pos
    @board[y_targ][x_targ] = @board[y_start][x_start].dup
    @board[y_start][x_start] = "__"

    # if @board[x_targ][y_targ] == "_"
    #   @board[x_targ][y_targ] =
    # else
    #
    #   @board[x_targ][y_targ] = "P"
    # end

  end

  # def generate_pieces
 #    [:black, :white].each do |color|
 #    end
 #  end
end

b = Board.new
b.display_board
b.place_a_move([1,1],[2,1])
b.place_a_move([7,6],[5,5])
b.display_board

