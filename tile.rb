require 'colorize'

class Tile
  attr_accessor :bomb, :flag, :adjacent_bombs, :revealed

  def initialize
    @adjacent_bombs = 0
    @bomb = false
    @flag = false
    @revealed = false
  end

  def bomb?
    @bomb
  end

  def colorize
    bomb? ? :red : :blue
  end
end
