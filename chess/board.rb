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

  # def valid_move?(start_pos, target_pos)
  #   x_start, y_start = str_to_coord(start_pos)
  #   x_targ, y_targ = str_to_coord(target_pos)
  #
  #
  # end

  def place_move(start_pos, target_pos) # returns true or false
    return false unless (start_pos && target_pos)

    x_start, y_start = str_to_coord(start_pos)
    x_targ, y_targ = str_to_coord(target_pos)

    p "y_start: #{y_start}, x_start: #{x_start}"
    p "y_targ: #{y_targ}, x_targ: #{x_targ}"

    piece = @chess_board[y_start][x_start]
    p "piece: #{piece.face} #{piece.color}"

    move_vector, move_range = make_move_vector(start_pos, target_pos)

    valid_direction = valid_direction_for?(piece, move_vector)
    p "valid_direction: #{valid_direction}"

    valid_range = valid_range_for?(piece, move_range)
    p "piece range: #{piece.range} vs. move_range: #{move_range}"
    p "valid_range: #{valid_range}"

    path_blocked = path_blocked_for?(piece, move_vector, start_pos, target_pos)

    if (valid_direction && valid_range && path_blocked)
      @chess_board[y_targ][x_targ] = @chess_board[y_start][x_start]
      @chess_board[y_start][x_start] = Blank.new
      puts "Move was placed"
      true
    else
      puts "Move was rejected!"
      false
    end
  end

  private

  def make_move_vector(start_pos, target_pos)
    x_start, y_start = str_to_coord(start_pos)
    x_targ, y_targ = str_to_coord(target_pos)
    piece = @chess_board[y_start][x_start]

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

    [move_vector, move_range]
  end

  # ask piece whether this vector is in its list
  def valid_direction_for?(piece, move_vector)
    possible_vectors = piece.vectors
    p "possible_vectors: #{possible_vectors}"

    possible_vectors.include?(move_vector)
  end

  def valid_range_for?(piece, move_range)
    move_range.to_i <= piece.range
  end

  def path_blocked_for?(piece, move_vector, start_pos, target_pos)
    x_start, y_start = str_to_coord(start_pos)
    x_targ, y_targ = str_to_coord(target_pos)

    path_blocked = true
    unless piece.is_a? Knight
      #third check
      # is there any other pieces in the path of the move
      # and path includes start and target positions
      vector_move_y, vector_move_x = move_vector
      path = []
      path_strings = []
      (piece.range - 1).times do |tile_index|
        tile_coord_x = x_start + (vector_move_x * tile_index)
        tile_coord_y = y_start + (vector_move_y * tile_index)
        tile_coords = [tile_coord_y.to_i, tile_coord_x.to_i]
        path << tile_coords

        #convert to chess lingo
        tile_string = coord_to_str(tile_coords)
        path_strings << tile_string
      end
      path.select! do |(row,col)|
        [row,col] != [y_start, x_start] &&
        [row,col] != [y_targ, x_targ] &&
        (0...8).include?(row) &&
        (0...8).include?(col)
      end
      p "path: #{path_strings} includes start and end tiles"
      p "path: #{path}"

      path_blocked = path.all? do |(row, col)|
        @chess_board[row][col].is_a? Blank # true
      end
      p "path_blocked: #{path_blocked}"
    end

    path_blocked
  end
end

if __FILE__ == $PROGRAM_NAME

  b = Board.new
  b.display_board
  # p "a2 = #{b.str_to_coord("a2")}"
  # p "a3 = #{b.str_to_coord("a3")}"
  b.place_move('f2','f3')
  b.display_board

  # b.place_move('e7','e5')
  # b.display_board
  #
  # b.place_move('g2','g4')
  # b.display_board
  #
  # p "#move queen"
  # b.place_move('d8','h4')
  # b.display_board
  #
  # p "#knight valid move 1"
  # b.place_move('b8','c6')
  # b.display_board
  #
  # p "#knight valid move 1"
  # b.place_move('c6','a5')
  # b.display_board
  #
  # p "quen takes a pawn 1"
  # b.place_move('h4','g4')
  # b.display_board
  #
  # p "#bishop valid move"
  # b.place_move('f8','d6')
  # b.display_board
  #
  # p "#bishop invalid move"
  # b.place_move('f1','d3')
  # b.display_board
end


