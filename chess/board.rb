require "logger"
require_relative "piece.rb"
require_relative "conversion.rb"

class Board
  attr_accessor :chess_board, :logger
  include Conversion

  def initialize
    @chess_board = generate_board
    @logger = Logger.new('board.log')
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
    board[0][0] = Castle.new(:w) # "Ca"
    board[0][1] = Knight.new(:w) # "Kn"
    board[0][2] = Bishop.new(:w) # "Bi"
    board[0][3] = Queen.new(:w) # "Qu"
    board[0][4] = King.new(:w) # "Ki"
    board[0][5] = Bishop.new(:w) # "Bi"
    board[0][6] = Knight.new(:w) # "Kn"
    board[0][7] = Castle.new(:w) # "Ca"
    board[1].map! { |tile| tile = Pawn.new(:w) } # "Pa"

    board[7][0] = Castle.new(:b) # "Ca"
    board[7][1] = Knight.new(:b) # "Kn"
    board[7][2] = Bishop.new(:b) # "Bi"
    board[7][3] = Queen.new(:b) # "Qu"
    board[7][4] = King.new(:b) # "Ki"
    board[7][5] = Bishop.new(:b) # "Bi"
    board[7][6] = Knight.new(:b) # "Kn"
    board[7][7] = Castle.new(:b) # "Ca"
    board[6].map! { |tile| tile = Pawn.new(:b) } # "Pa"

    board
  end

  def show_board
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

  def coords_with_pieces
    positions = []
    chess_board.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        positions << [row_idx, col_idx] unless piece.is_a? Blank
      end
    end
    positions
  end

  def show_king_status(color)
    # color = player.color
    king_like = King.new(color)
    king_pos = (positions_for_piece_like(king_like)).last
    king_pos = coord_to_str(king_pos)
    # p "king_pos: #{king_pos}"

    opponent_color = (color == :w) ? :b : :w

    coords_with_pieces.each do |(row_idx, col_idx)|
      piece = chess_board[row_idx][col_idx]
      piece_pos = coord_to_str([row_idx, col_idx])
      if piece.color == opponent_color
        dummy_board = Board.new
        chess_board.each_with_index do |row, row_idx|
          dummy_board.chess_board[row_idx] = []
          row.each_with_index do |piece, col_idx|
            dummy_board.chess_board[row_idx][col_idx] = piece.dup
          end
        end
        status = dummy_board.place_move_for(opponent_color, piece_pos, king_pos)
        logger.info "status of attempted move #{piece_pos} to #{king_pos}: #{status}"
        p "#{color} in check [#{piece_pos} to #{king_pos}]" if status == true
      end
    end
  end



  # def available_moves_for(str_pos)
  #   col, row = str_to_coord(str_pos)
  #   piece = chess_board[row][col]
  #   puts "piece #{piece.face}"
  #   color = piece.color
  #   # piece_positions = # generating here
  #
  # end

  def positions_for_piece_like(find_piece)
    matches = []
    chess_board.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        if (piece.color == find_piece.color && piece.class == find_piece.class)
          matches << [row_idx, col_idx]
        end
      end
    end
    matches
  end

  def place_move_for(color, start_pos, target_pos) # returns true or false
    # logger = Logger.new('place_move_for.log')

    logger.info "start_pos and target_pos exist: #{(start_pos && target_pos)}"
    return false unless (start_pos && target_pos)

    # p "available moves for: #{start_pos}"
    # p available_moves_for(start_pos)
    #
    # p "available moves for: #{target_pos}"
    # p available_moves_for(target_pos)

    x_start, y_start = str_to_coord(start_pos)
    x_targ, y_targ = str_to_coord(target_pos)

    logger.info "y_start: #{y_start}, x_start: #{x_start}"
    logger.info "y_targ: #{y_targ}, x_targ: #{x_targ}"

    piece = @chess_board[y_start][x_start]
    logger.info "piece: #{piece.face} #{piece.color}"

    piece_targ = chess_board[y_targ][x_targ]
    logger.info "#{color} trying to take own piece? #{(piece.color == piece_targ.color)}"
    return false if piece.color == piece_targ.color

    logger.info "#{color}'s piece? #{piece.color == color}"
    return false unless piece.color == color

    move_vector, move_range = make_move_vector(start_pos, target_pos)

    valid_direction = valid_direction_for?(piece, move_vector)
    logger.info "valid_direction: #{valid_direction}"

    valid_range = valid_range_for?(piece, move_range)
    logger.info "piece range: #{piece.range} vs. move_range: #{move_range}"
    logger.info "valid_range: #{valid_range}"

    path_open = path_open_for?(piece, start_pos, target_pos)

    if (valid_direction && valid_range && path_open)
      @chess_board[y_targ][x_targ] = @chess_board[y_start][x_start]
      @chess_board[y_start][x_start] = Blank.new
      logger.info "Move was placed"
      true
    else
      logger.info "Move was rejected!"
      false
    end
  end

  private

  def make_move_vector(start_pos, target_pos)
    x_start, y_start = str_to_coord(start_pos) #[coord_col, coord_row]
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
    logger.info "vector_move_x: #{vector_move_x}, vector_move_y: #{vector_move_y}"
    logger.info "move_vector: #{move_vector}"
    logger.info "move_range: #{move_range}"

    [move_vector, move_range]
  end

  # ask piece whether this vector is in its list
  def valid_direction_for?(piece, move_vector)
    possible_vectors = piece.vectors
    logger.info "possible_vectors: #{possible_vectors}"

    possible_vectors.include?(move_vector)
  end

  def valid_range_for?(piece, move_range)
    move_range.to_i <= piece.range
  end

  def in_bounds?(row, col)
    (0...7).include?(row) && (0...7).include?(col)
  end

  def path_for(piece, start_pos, target_pos)
    x_start, y_start = str_to_coord(start_pos)
    x_targ, y_targ = str_to_coord(target_pos)

    move_vector, move_range = make_move_vector(start_pos, target_pos)

    vector_move_y, vector_move_x = move_vector
    path = []
    path_strings = []
    (0...piece.range).each do |tile_index|
      tile_coord_x = x_start + (vector_move_x * tile_index)
      tile_coord_y = y_start + (vector_move_y * tile_index)
      tile_coords = [tile_coord_y.to_i, tile_coord_x.to_i]

      next unless in_bounds?(tile_coord_y, tile_coord_x)

      path << tile_coords
      break if tile_coords == [y_targ, x_targ]

      #convert to chess lingo
      tile_string = coord_to_str(tile_coords)
      path_strings << tile_string
    end
    logger.info "path before select: #{path}"

    path.select! do |(row,col)|
      [row,col] != [y_start, x_start] &&
      [row,col] != [y_targ, x_targ]
    end

    logger.info "path: #{path_strings} includes start and end tiles"
    logger.info "path: #{path}"
    path
  end

  def path_open_for?(piece, start_pos, target_pos)

    path_open = true
    unless piece.is_a? Knight
      path = path_for(piece, start_pos, target_pos)
      path_open = path.nil?

      path_open = path.all? do |(row, col)|
        @chess_board[row][col].is_a? Blank # true
      end
      logger.info "path_open? #{path_open}"
    end

    path_open
  end
end

if __FILE__ == $PROGRAM_NAME

  b = Board.new
  b.show_board
  # p "a2 = #{b.str_to_coord("a2")}"
  # p "a3 = #{b.str_to_coord("a3")}"
  b.place_move_for('f2','f3')
  b.show_board

  # b.place_move_for('e7','e5')
  # b.show_board
  #
  # b.place_move_for('g2','g4')
  # b.show_board
  #
  # p "#move queen"
  # b.place_move_for('d8','h4')
  # b.show_board
  #
  # p "#knight valid move 1"
  # b.place_move_for('b8','c6')
  # b.show_board
  #
  # p "#knight valid move 1"
  # b.place_move_for('c6','a5')
  # b.show_board
  #
  # p "quen takes a pawn 1"
  # b.place_move_for('h4','g4')
  # b.show_board
  #
  # p "#bishop valid move"
  # b.place_move_for('f8','d6')
  # b.show_board
  #
  # p "#bishop invalid move"
  # b.place_move_for('f1','d3')
  # b.show_board
end


