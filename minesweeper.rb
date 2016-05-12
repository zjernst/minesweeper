class Minesweeper
  attr_accessor :board

  def initialize()
    @board = Board.new
  end

  def run
    play_round until game_over?
  end

  def play_round
  end

end
