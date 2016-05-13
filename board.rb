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

  def populate_bombs(diff = 10)
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
        if tile.revealed
          print " #{tile.adjacent_bombs}"
        else
          print " *"
        end
      end
      puts " "
    end
  end

  def set_adjacent_bombs
    @grid.each_with_index do |row,row_index|
      row.each_with_index do |tile, column_index|
        neighbors = adjacent_tiles([row_index, column_index])
        bombs = 0
        #byebug
        neighbors.each do |neighbor|
          bombs += 1 if self[neighbor].bomb?
        end
        tile.adjacent_bombs = bombs
      end
    end
  end

  def add_coords(delta, pos)
    [delta[0] + pos[0], delta[1] + pos[1]]
  end

  def adjacent_tiles(position)
    x,y = position
    relatives = []

    deltas = [1,0,-1].permutation(2).to_a
    deltas << [-1,-1]
    deltas << [1,1]

    deltas.each do |delta|
      relatives << add_coords(delta, position)
    end

    relatives.reject! do |x, y|
      (x < 0 || y < 0) || (x > 8 || y > 8)
    end

    relatives
  end

  def is_bomb?(pos)
    tile = self[pos]
    tile.bomb?
  end

  def reveal(pos)
    self[pos].revealed = true
    if self[pos].adjacent_bombs == 0
      neighbors = adjacent_tiles(pos)
      #byebug
      neighbors.each do |neighbor|
        reveal(neighbor) if !self[neighbor].revealed
      end
    end
  end

  def flag(pos)
    self[pos].flag = true
  end
end
