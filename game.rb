WIN = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

class Board
  attr_reader :grid

  def initialize
    @grid = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

def print_board(board)
  puts ' %d | %d | %d' % board.grid[0..2]
  puts ' %d | %d | %d' % board.grid[3..5]
  puts ' %d | %d | %d' % board.grid[6..8]
end

board = Board.new
turns = 9
p1 = Player.new('X')
p2 = Player.new('O')
# Improve game start
while turns > 0
  print_board board
  # Improve input handling and game logic
  puts "Where do you want to place your marker? (%s): " % p1.marker 
  gets
end
