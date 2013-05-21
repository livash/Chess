require_relative "piece.rb"

class Board
  # GAME_MAP = []

  attr_accessor :chess_board, :pieces

  def initialize
    # @pieces = generate_pieces
    @chess_board = generate_board
    # commit_pieces_to_board
  end

  def generate_board
    board = []
    8.times do |rows|
      row = []
      8.times do |row_element|
        row << EmptyPiece.new
      end
      board << row
    end

    add_pieces(board)
  end

  def add_pieces(board)
    board[0][0] = Castle.new # "Ca"
    board[0][1] = Knight.new # "Kn"
    board[0][2] = Bishop.new # "Bi"
    board[0][3] = King.new # "Ki"
    board[0][4] = Queen.new # "Qu"
    board[0][5] = Bishop.new # "Bi"
    board[0][6] = Knight.new # "Kn"
    board[0][7] = Castle.new # "Ca"
    board[1].map! { |tile| tile = Pawn.new } # "Pa"

    board[7][0] = Castle.new # "Ca"
    board[7][1] = Knight.new # "Kn"
    board[7][2] = Bishop.new # "Bi"
    board[7][3] = King.new # "Ki"
    board[7][4] = Queen.new # "Qu"
    board[7][5] = Bishop.new # "Bi"
    board[7][6] = Knight.new # "Kn"
    board[7][7] = Castle.new # "Ca"
    board[6].map! { |tile| tile = Pawn.new } # "Pa"

    board
  end


  def display_board
    puts
    puts "  a  b  c  d  e  f  g  h"
    puts "  0  1  2  3  4  5  6  7"
    @chess_board.each_with_index do |row, idx|
      row_view = row.map { |piece| piece.face}.join(" ")
      puts "#{idx} #{row_view}"
    end
  end

  def place_a_move(start_pos, target_pos)
    y_start,x_start = start_pos
    y_targ, x_targ = target_pos
    @chess_board[y_targ][x_targ] = @chess_board[y_start][x_start]
    @chess_board[y_start][x_start] = EmptyPiece.new

    # if @chess_board[x_targ][y_targ] == "_"
    #   @chess_board[x_targ][y_targ] =
    # else
    #
    #   @chess_board[x_targ][y_targ] = "P"
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


