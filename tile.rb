require 'colorize'

class Tile
  attr_accessor :bomb, :flag, :adjacent_bombs

  def initialize
    @adjacent_bombs = 0
    @bomb = false
    @flag = false
  end

  def bomb?
    @bomb
  end

  def colorize
    bomb? ? :red : :blue
  end
end
