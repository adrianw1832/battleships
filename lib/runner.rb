require_relative 'ship'
require_relative 'board'
require_relative 'player'
require_relative 'game'

ship1 = Ship.submarine
ship2 = Ship.submarine
board1 = Board.new
board2 = Board.new
player1 = Player.new('Adrian', board1)
player2 = Player.new('Ken', board2)
player1.place(ship1, :A1, :Vertically)
player2.place(ship2, :A1, :Horizontally)
game = Game.new(player1, player2)
game.start
