require_relative "piece.rb"
require_relative "conversion.rb"

class Board
  attr_accessor :chess_board, :pieces
  include Conversion

  def initialize
    @chess_board = generate_board
  end

  def str_to_coord(str) # f3
    col_map = ("a".."g").to_a
    str_col, str_row = str.chars.to_a
    coord_col = col_map.index(str_col)
    coord_row = (str_row.to_i - 1)
    [coord_col, coord_row] #
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
        board[row][col] = Blank.new
      end
    end

    add_pieces(board)
  end

  def add_pieces(board)
    board[0][0] = Castle.new(:b) # "Ca"
    board[0][1] = Knight.new(:b) # "Kn"
    board[0][2] = Bishop.new(:b) # "Bi"
    board[0][3] = King.new(:b) # "Ki"
    board[0][4] = Queen.new(:b) # "Qu"
    board[0][5] = Bishop.new(:b) # "Bi"
    board[0][6] = Knight.new(:b) # "Kn"
    board[0][7] = Castle.new(:b) # "Ca"
    board[1].map! { |tile| tile = Pawn.new(:b) } # "Pa"

    board[7][0] = Castle.new(:w) # "Ca"
    board[7][1] = Knight.new(:w) # "Kn"
    board[7][2] = Bishop.new(:w) # "Bi"
    board[7][3] = King.new(:w) # "Ki"
    board[7][4] = Queen.new(:w) # "Qu"
    board[7][5] = Bishop.new(:w) # "Bi"
    board[7][6] = Knight.new(:w) # "Kn"
    board[7][7] = Castle.new(:w) # "Ca"
    board[6].map! { |tile| tile = Pawn.new(:w) } # "Pa"

    board
  end

  def display_board
    puts
    puts "  | a    b    c    d    e    f    g    h  "
    puts "  ________________________________________"
    @chess_board.each_with_index do |row, idx|
      row_view = row.map do |piece|
        case piece.color
        when :b
          "<#{piece.face}>"
        when :w
          "[#{piece.face}]"
        else
          "#{piece.face}"
        end
        # (piece.face + '_' + piece.color.to_s)
      end
      puts "#{8 - idx}| #{row_view.join(' ')}"
      puts " |"
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

if __FILE__ == $PROGRAM_NAME

  b = Board.new
  input_string = 'd6'
  puts "for position '#{input_string}' we get:"
  coord = b.str_to_coord(input_string)
  puts "coord #{coord}"
  #
  # string = b.coord_to_str(coord)
  # puts "string = #{string}"
  #
  # puts "back again:"
  # p b.str_to_coord(string)
  b.display_board
  #b.place_move()
  # b.place_move([7,6],[5,5])
  # b.display_board

end


