# require_relative "board.rb"

puts "Piece is loaded......"

class Piece
  DIAGONAL_MOVES = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  ORTHOGONAL_MOVES = [[-1, 0], [0, -1], [0, 1], [1, 0]]

  attr_reader :face
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

  def possible_moves
    # TODO: add checking
    [0, 1]
  end
end