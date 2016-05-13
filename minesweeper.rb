require_relative 'board'
require 'byebug'

class Minesweeper
  attr_accessor :board

  def initialize()
    @board = Board.new
    @playing = true
  end

  def run
    @board.populate_bombs
    play_round while @playing
  end

  def get_input
    puts "Select a tile"
    tile = parse_input(gets.chomp)
  end

  def game_over
    puts "Game over!"
    @playing = false
  end

  def flag_or_reveal(pos)
    puts "Would you like to flag or reveal this tile (f or r)"
    input = gets.chomp
    if input == "f"
      @board.flag(pos)
    elsif input == "r"
      if @board.is_bomb?(pos)
        game_over
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
    @board.render
    flag_or_reveal(get_input)
  end

end

game = Minesweeper.new
game.run
