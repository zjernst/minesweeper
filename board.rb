require_relative 'tile'
require 'byebug'

class Board
  attr_reader :grid

  def initialize
    @grid = self.default_grid
  end

  def default_grid
    Array.new(9) do
      Array.new(9) {Tile.new}
    end
  end

  def populate_mines(diff = 15)
    tile_mines = @grid.flatten.sample(diff)
    tile_mines.each do |tile|
      tile.bomb = true
    end
  end

  def render
    p " #{(0..8).to_a.join(" ")}"
    @grid.each_with_index do |row, index|
      print index
      row.each do |tile|
        print " #{tile.adjacent_bombs}"
      end
      puts " "
    end
  end

  def reveal
  end
end
