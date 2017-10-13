class HumanPlayer
  def initialize(name)
    @name = name
  end

  def get_input
    print "Pick a position to reveal your card (eg:1,2):"
    gets.chomp.split(",").map(&:to_i)
  end

  

end
