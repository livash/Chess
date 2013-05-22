require_relative "conversion.rb"
#require_relative "board.rb"

class Piece
  DIAGONAL_MOVES = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  ORTHOGONAL_MOVES = [[-1, 0], [0, -1], [0, 1], [1, 0]]

  attr_reader :face, :color
  include Conversion

  def initialize(color)
    @color = color
  end
end

class Blank < Piece
  def initialize(color = nil)
    super(color)
    @face = "____"
  end
end

class King < Piece
  attr_reader :range
  def initialize(color)
    super(color)
    @face = "Ki"
    @range = 1
  end

  def vectors
    DIAGONAL_MOVES + ORTHOGONAL_MOVES
  end
end

class Queen < Piece
   attr_reader :range
  def initialize(color)
    super(color)
    @face = "Qu"
    @range = 8
  end

  def vectors
     DIAGONAL_MOVES + ORTHOGONAL_MOVES
  end
end

class Bishop < Piece
   attr_reader :range
  def initialize(color)
    super(color)
    @face = "Bi"
    @range = 8
  end

  def vectors
    DIAGONAL_MOVES
  end
end

class Knight < Piece
  attr_reader :range
  def initialize(color)
    super(color)
    @face = "Kn"
    @range = 4
  end

  def vectors
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
  attr_reader :range
  def initialize(color)
    super(color)
    @face = "Ca"
    @range = 8
  end

  def vectors
    ORTHOGONAL_MOVES
  end
end

class Pawn < Piece
  attr_reader :range
  def initialize(color)
    super(color)
    @face = "Pa"
    @range = 2
  end

  def vectors
    # TODO: add checking
    case self.color
    when :b
      [[1,0], [1,-1], [1,1]]
    when :w
      [[-1,0], [-1,-1], [-1,1]]
    else
      raise "Need color to move Pawn."
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  p = Pawn.new(:b)
  path = p.build_path('b2', 'b3')
  p path
  path.each { |coord_array| puts p.coord_to_str(coord_array) }
end
