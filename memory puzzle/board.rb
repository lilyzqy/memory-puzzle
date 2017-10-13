class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(4) { Array.new(4) }
  end

  def populate
    cards = []
    card_faces = (1..10).to_a.map(&:to_s) + ["J","Q","K"]
    8.times do
      card = Card.new(card_faces.sample)
      cards << card
      cards << Card.new(card.face_value)
    end
    cards.shuffle!
    arr = positions

    16.times do |num|
      pos = arr[num]
      self[pos] = cards[num]
    end

  end

  def [](pos)
    r, c = pos
    grid[r][c]
  end

  def []=(pos, value)
    r,c = pos
    grid[r][c] = value
  end

  def positions
    arr = []
    4.times do |r|
      4.times do |c|
        arr << [r,c]
      end
    end
    arr
  end

  def render
    row0 = "0 |"
    (0..3).each do |col|
      row0 << (grid[0][col].face_up ? " #{grid[0][col].to_s.ljust(2)}|"  : " * |")
    end
    row1 = "1 |"
    (0..3).each do |col|
      row1 << (grid[1][col].face_up ? " #{grid[1][col].to_s.ljust(2)}|" : " * |")
    end
    row2 = "2 |"
    (0..3).each do |col|
      row2 << (grid[2][col].face_up ? " #{grid[2][col].to_s.ljust(2)}|" : " * |")
    end
    row3 = "3 |"
    (0..3).each do |col|
      row3 << (grid[3][col].face_up ? " #{grid[3][col].to_s.ljust(2)}|" : " * |")
    end

    puts "    0   1   2   3 "
    puts "  |---------------|"
    puts row0
    puts "  |---------------|"
    puts row1
    puts "  |---------------|"
    puts row2
    puts "  |---------------|"
    puts row3
    puts "  |---------------|"
  end

  def won?
    arr = positions
    arr.all? do |pos|
      self[pos].face_up == true
    end
  end

  def reveal(guessed_pos)
    return self[guessed_pos].face_value if self[guessed_pos].face_up == false
  end

end

# board = Board.new
# board.populate
# board.render
# p board.grid
# p board.won?
# p board.reveal([0,0])
# p board.grid
