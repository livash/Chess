#require_relative "board.rb"

puts "Piece is loaded......"

class Piece
  DIAGONAL_MOVES = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  ORTHOGONAL_MOVES = [[-1, 0], [0, -1], [0, 1], [1, 0]]

  attr_reader :face

  def str_to_coord(str)
    col_map = ("a".."g").to_a
    col, row = str.chars.to_a

    [col_map.index(col), (row.to_i - 1)] #[column, row]
  end

  def coord_to_str(coord_array)
    col_map = ("a".."g").to_a
    row, col= coord_array
    col_string = col_map[col].to_s
    row_string = (row + 1).to_s
    col_string + row_string
  end

end

class EmptyPiece < Piece
  def initialize
    @face = "__"
  end
end

class King < Piece
  def initialize
    @face = "Ki"
  end

  def possible_moves
    DIAGONAL_MOVES + ORTHOGONAL_MOVES
  end
end

class Queen < Piece
  def initialize
    @face = "Qu"
  end

  def possible_moves
    KING_MOVES.map do |(x, y)|
      expand_arr = []
      1.upto(7) { |i| expand_arr << [x * i, y * i] }
      expand_arr
    end.flatten(1)
  end
end

class Bishop < Piece
  def initialize
    @face = "Bi"
  end

  def possible_moves
    DIAGONAL_MOVES.map do |(x, y)|
      expand_arr = []
      1.upto(7) { |i| expand_arr << [x * i, y * i] }
      expand_arr
    end.flatten(1)
  end
end

class Knight < Piece
  def initialize
    @face = "Kn"
  end

  def possible_moves
    [
      [-2, -1],
      [-2,  1],
      [-1, -2],
      [-1,  2],
      [ 1, -2],
      [ 1,  2],
      [ 2, -1],
      [ 2,  1]
    ]
  end
end

class Castle < Piece
  def initialize
    @face = "Ca"
  end

  def possible_moves
    ORTHOGONAL_MOVES.map do |(x, y)|
      expand_arr = []
      1.upto(7) { |i| expand_arr << [x * i, y * i] }
      expand_arr
    end.flatten(1)
  end
end

class Pawn < Piece
  def initialize
    @face = "Pa"
  end

  def build_path(start_pos, target_pos)
    start_col, start_row = str_to_coord(start_pos)
    target_col, target_row = str_to_coord(target_pos)

    path = [[start_row, start_col]]
    possible_moves.map do |(row, column)|
      path << [start_row + row, start_col + column]
    end
    path
  end

  def possible_moves
    # TODO: add checking
    [[1,0]]
  end
end




p = Pawn.new
path = p.build_path('b2', 'b3')
p path

path.each { |coord_array| puts p.coord_to_str(coord_array) }







