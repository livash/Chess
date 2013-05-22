require_relative "piece.rb"

class Board
  attr_accessor :chess_board, :pieces

  def initialize
    @chess_board = generate_board
  end

  def str_to_coord(str)
    col_map = ("a".."g").to_a
    col, row = str.chars.to_a

    [(row.to_i - 1), col_map.index(col)] #[row, col]
  end

  def coord_to_str(coord_array)
    col_map = ("a".."g").to_a
    row, col= coord_array
    col_string = col_map[col].to_s
    row_string = (row + 1).to_s
    col_string + row_string
  end


  def generate_board
    board = []
    8.times do |row|
      board[row] = []
      8.times do |col|
        board[row][col] = EmptyPiece.new
      end
    end
    add_pieces(board)

    # board = []
    # 8.times do |rows|
    #   row = []
    #   8.times do |row_element|
    #     row << EmptyPiece.new
    #   end
    #   board << row
    # end
    # board = board.transpose
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

  def on_board?(position)
    # positions
  end

  # def valid_path?
  #
  # end
  #FIGURE OUT  X  AND   Y
  #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  def valid_move?(start_pos, target_pos)
    start_col, start_row = str_to_coord(star_pos)
    target_col, target_row = str_to_coord(target_pos)

    piece = chess_board[start_row][start_col]
    path_array = piece.build_path(start_pos, target_pos) # [start_pos,[],[] ....target_pos]

    #if path

    # are these positions on the board?
    return false unless on_board?(start_pos) && on_board?(target_pos)

    # can the piece at start_pos make this move?
    piece_to_move = board
    return false unless valid_path?(start_pos, target_pos)

    # is start_pos a piece for this player?

    # does making this move jeopardize the players king?
    # is there a piece blocking this move?
  end

  def place_move(start_pos, target_pos) # returns true or false
    y_start, x_start = start_pos
    y_targ, x_targ = target_pos

    #if valid_move?(start_pos, target_pos)
      @chess_board[y_targ][x_targ] = @chess_board[y_start][x_start]
      @chess_board[y_start][x_start] = EmptyPiece.new
      puts "Move was placed"
    # true
    # else
#       puts "Move was rejected!"
#       false
#     end
  end
end

b = Board.new
coord = b.str_to_coord('d6')
puts "coord #{coord}"

string = b.coord_to_str(coord)
puts "string = #{string}"

puts "back again:"
p b.str_to_coord(string)

# b.display_board
# b.place_move([1,1],[2,1])
# b.place_move([7,6],[5,5])
# b.display_board


