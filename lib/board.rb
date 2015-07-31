class Board
  attr_reader :positions, :hits, :misses, :remaining_hits

  def initialize
    @positions = {}
    @hits = []
    @misses = []
    @remaining_hits = 0
  end

  def place_ship(ship, coord, direction)
    fail_tests_for_place(all_coords(ship.size, coord, direction))
    log_data(ship, all_coords(ship.size, coord, direction))
  end

  def check_board(coord)
    fail_tests_for_check_board(coord)
    positions.keys.include?(coord) ? its_a_hit(coord) : its_a_miss(coord)
  end

  def all_sunk?
    remaining_hits == 0
  end

  private

  def all_coords(size, coord, direction)
    coords = [coord]
    (size - 1).times { coords << (direction == :Vertically ? next_vertical_coord(coords.last) : next_horizontal_coord(coords.last)) }
    coords
  end

  def next_vertical_coord(coord)
    letter, number = coord.to_s.split('', 2)
    (letter + number.next).to_sym
  end

  def next_horizontal_coord(coord)
    coord.to_s.reverse.next.reverse.to_sym
  end

  def fail_tests_for_place(coords_array)
    fail 'Overlapping ships' unless (positions.keys & coords_array).empty?
    fail 'Outside of board' if coords_array.any?(&off_board?)
  end

  def log_data(ship, coords_array)
    @remaining_hits += ship.size
    coords_array.each { |coordinate| @positions[coordinate] = ship }
  end

  def fail_tests_for_check_board(coord)
    fail 'You have already hit that spot' if hits.include?(coord)
    fail 'You have already missed that spot' if misses.include?(coord)
  end

  def its_a_hit(coord)
    mark_ship(coord)
    log_hits(coord)
  end

  def its_a_miss(coord)
    log_misses(coord)
  end

  def mark_ship(coord)
    positions[coord].got_hit
    @remaining_hits -= 1
  end

  def off_board?
    proc do |coordinate|
      letter, number = coordinate.to_s.split('', 2)
      letter.ord - 64 > 10 || number.to_i > 10
    end
  end

  def log_hits(coord)
    @hits << coord
    :hit
  end

  def log_misses(coord)
    @misses << coord
    :miss
  end
end
