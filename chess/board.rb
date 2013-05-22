require_relative "piece.rb"
require_relative "conversion.rb"

class Board
  attr_accessor :chess_board, :pieces
  include Conversion

  def initialize
    @chess_board = generate_board
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
    board[0][3] = Queen.new(:b) # "Qu"
    board[0][4] = King.new(:b) # "Ki"
    board[0][5] = Bishop.new(:b) # "Bi"
    board[0][6] = Knight.new(:b) # "Kn"
    board[0][7] = Castle.new(:b) # "Ca"
    board[1].map! { |tile| tile = Pawn.new(:b) } # "Pa"

    board[7][0] = Castle.new(:w) # "Ca"
    board[7][1] = Knight.new(:w) # "Kn"
    board[7][2] = Bishop.new(:w) # "Bi"
    board[7][3] = Queen.new(:w) # "Qu"
    board[7][4] = King.new(:w) # "Ki"
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
    x_start, y_start = str_to_coord(start_pos)
    x_targ, y_targ = str_to_coord(target_pos)

    p "y_start: #{y_start}, x_start: #{x_start}"
    p "y_targ: #{y_targ}, x_targ: #{x_targ}"

    piece = @chess_board[y_start][x_start]
    p "piece: #{piece.face} #{piece.color}"

    unless piece.is_a? Knight
      #calc vector and its length/range
      vector_move_x = (x_targ - x_start).to_f
      vector_move_x = vector_move_x / (x_targ - x_start).to_f.abs unless (x_targ - x_start).zero?

      vector_move_y = (y_targ - y_start).to_f
      vector_move_y = vector_move_y / (y_targ - y_start).to_f.abs unless (y_targ - y_start).zero?

      move_vector = [vector_move_y, vector_move_x]
      move_range = Math.sqrt((y_targ - y_start) * (y_targ - y_start) + (x_targ - x_start) * (x_targ - x_start))
    else # if piece is a knight
       vector_move_x = (x_targ - x_start)
       vector_move_y = (y_targ - y_start)
       move_vector = [vector_move_y, vector_move_x]
       move_range = Math.sqrt((y_targ - y_start) * (y_targ - y_start) + (x_targ - x_start) * (x_targ - x_start))
    end

    p "vector_move_x: #{vector_move_x}, vector_move_y: #{vector_move_y}"
    p "move_vector: #{move_vector}"
    p "move_range: #{move_range}"

    #ask piece whether this vector is ints list

    possible_vectors = piece.vectors
    p "possible_vectors: #{possible_vectors}"

    first_check = possible_vectors.include?(move_vector)
    p "first_check: #{first_check}"

    second_check = (move_range.to_i <= piece.range)
    p "piece range: #{piece.range} vs. move_range: #{move_range}"
    p "second_check: #{second_check}"

    #third check
    # is there any other pieces in the path of the move
    # and path includes start and target positions
    path = []
    piece.range.times do |tile_index|
      tile_coord_x = x_start + (vector_move_x * tile_index)
      tile_coord_y = y_start + (vector_move_y * tile_index)
      tile_coords = [tile_coord_y, tile_coord_x]
      path << tile_coords
    end
    p "path: #{path}"

    if (first_check && second_check )#valid_move?(start_pos, target_pos)
      @chess_board[y_targ][x_targ] = @chess_board[y_start][x_start]
      @chess_board[y_start][x_start] = Blank.new
      puts "Move was placed"
    else
      puts "Move was rejected!"
    end
  end
end

if __FILE__ == $PROGRAM_NAME

  b = Board.new
  b.display_board
  # p "a2 = #{b.str_to_coord("a2")}"
  # p "a3 = #{b.str_to_coord("a3")}"
  b.place_move('f2','f3')
  b.display_board

  b.place_move('e7','e5')
  b.display_board

  b.place_move('g2','g4')
  b.display_board

  b.place_move('d8','h4')
  b.display_board

  p "#knight valid move"
  b.place_move('b8','c6')
  b.display_board

  p "#knight invalid move"
  b.place_move('c6','a5')
  b.display_board

  p "quen takes a pawn"
  b.place_move('h4','g4')
  b.display_board

  p "quen takes a pawn"
  b.place_move('g4','f3')
  b.display_board
  # p "#knight invalid move"
  # b.place_move('g8','c4')
  # b.display_board


  # b.place_move([7,6],[5,5])
  # b.display_board

end


