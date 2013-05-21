require_relative "board"

class Piece
  DIAGONAL_MOVES = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  ORTHOGONAL_MOVES = [[-1, 0], [0, -1], [0, 1], [1, 0]]
end

class King < Piece
  def possible_moves
    DIAGONAL_MOVES + ORTHOGONAL_MOVES
  end
end

class Queen < Piece
  def possible_moves
    KING_MOVES.map do |(x, y)|
      expand_arr = []
      1.upto(7) { |i| expand_arr << [x * i, y * i] }
      expand_arr
    end.flatten(1)
  end
end

class Bishop < Piece

  def possible_moves
    DIAGONAL_MOVES.map do |(x, y)|
      expand_arr = []
      1.upto(7) { |i| expand_arr << [x * i, y * i] }
      expand_arr
    end.flatten(1)
  end
end

class Knight < Piece
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
  def possible_moves
    ORTHOGONAL_MOVES.map do |(x, y)|
      expand_arr = []
      1.upto(7) { |i| expand_arr << [x * i, y * i] }
      expand_arr
    end.flatten(1)
  end
end

class Pawn < Piece
  def possible_moves
    # TODO: add checking
    [0, 1]
  end
end