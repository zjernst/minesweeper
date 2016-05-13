class Minesweeper
  attr_accessor :board

  def initialize()
    @board = Board.new
  end

  def run
    play_round until game_over?
  end

  def get_input
    puts "Select a tile"
    tile = parse_input(gets.chomp)
  end

  def flag_or_reveal(pos)
    puts "Would you like to flag or reveal this tile (f or r)"
    input = gets.chomp
    if input == "f"
      @board.flag(pos)
    elsif input == "r"
      if @board.is_bomb?(pos)
        puts "Game over!"
        break
      else
        @board.reveal(pos)
      end
    else
      puts "Invalid input"
      flag_or_reveal
    end
  end

  def parse_input(string)
    string.split(',').map(&:to_i)
  end

  def play_round
    puts

  end

end
