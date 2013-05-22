class	Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def ask_move
    # OPTIMIZE: add error checking
    print "Enter your move [ex: f4,f5]: "
    start_pos, target_pos = gets.chomp.split(",")
    [start_pos, target_pos]
  end
end

if __FILE__ == $PROGRAM_NAME
  player = Player.new('Olena', :w)
  input = player.ask_move
  
  puts "Received your input"
  puts "Your input was #{input}"
  
end