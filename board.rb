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

  def [](pos)
    x,y = pos
    grid[x][y]
  end

  def populate_bombs(diff = 15)
    tile_mines = @grid.flatten.sample(diff)
    tile_mines.each do |tile|
      tile.bomb = true
    end
    set_adjacent_bombs
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

  def set_adjacent_bombs
    @grid.each_with_index do |row,row_index|
      row.each_with_index do |tile, column_index|
        @grid[row_index + 1 ,column_index]

      end
    end


  end

  def add_coords(delta, pos)
    [x, y] = [delta[0] + pos[0], delta[1] + pos[1]]
  end

  def adjacent_tiles(position)
    x,y = position
    relatives = []

    deltas = [1,0,-1].permutation(2).to_a
    deltas << [-1,-1]
    deltas << [1,1]

    deltas.each do |delta|
      relatives << add_coords(delta, pos)
    end

    relatives.reject do |x, y|
      x < 0 || y <0
    end

  end

  def reveal(pos)
    tile = self[pos]
    tile.bomb?
  end

  def flag(pos)
    self[pos].flag = true
  end
end
