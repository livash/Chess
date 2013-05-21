class	Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ask_move
    # OPTIMIZE: add error checking
    print "Enter your move [f2, f3]: "
    start_pos, target_pos = gets.chomp.split(",")
    [start_pos, target_pos]
  end
end