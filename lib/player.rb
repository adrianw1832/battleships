require_relative 'game'

class Player
  attr_reader :board, :name

  def initialize(name, board)
    @board = board
    @name = name
  end

  def place(ship, coordinate, direction)
    board.place_ship(ship, coordinate, direction)
  end

  def fire(coordinate)
    board.check_board(coordinate)
  end

  def hits
    board.hits
  end

  def misses
    board.misses
  end
end
