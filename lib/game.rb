class Game
  attr_reader :turn

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn = 1
  end

  def start
    puts 'Battleships game has begun!'
    name1 = @player1.name
    name2 = @player2.name
    while true
      name = @turn == 1 ? name1 : name2
      puts "#{name}, please choose a coordinate to fire at"
      player_coord = gets.chomp.to_sym
      if @turn == 1
        puts @player2.fire(player_coord)
      else
        puts @player1.fire(player_coord)
      end
      @turn == 1 ? @turn = 2 : @turn = 1
      return "Game over, #{name} wins!" if @player2.board.all_sunk?
      return "Game over, #{name} wins!" if @player1.board.all_sunk?
    end
  end
end
