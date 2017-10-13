require_relative "card"
require_relative "board"
require_relative "humanplayer"
require "byebug"


class Game
  attr_reader :board, :player

  def initialize(player)
    @board = Board.new
    @previous_guess_pos = []
    @player = player
  end

  def play
    board.populate
    turn = 0
    until board.won?
      system("clear")
      board.render
      begin
        guessed_pos = player.get_input
        if !board.positions.include?(guessed_pos)
          puts "Your guessed position was not within bounds!"
          raise "Your guessed position was not within bounds!"
        end
      rescue
        retry
      end
      make_guess(guessed_pos)
      turn += 1
    end
    puts "Congratulations! You Won in #{turn/2} turns!"
  end

  def make_guess(guessed_pos)
    if face_up_count.even?
      board[guessed_pos].reveal
      @previous_guess_pos = guessed_pos
    else
      board[guessed_pos].reveal
      unless board[guessed_pos].face_value == board[@previous_guess_pos].face_value
        board.render
        sleep(3)
        board[guessed_pos].hide
        board[@previous_guess_pos].hide
        @previous_guess_pos = []
      end
    end
  end

  def face_up_count
    count = 0
    board.grid.flatten.each do |card|
      count += 1 if card.face_up == true
    end
     count
  end
end

game = Game.new(HumanPlayer.new("Adeel"))
game.play
