WIN = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

# Main Event to handle
class Game
  attr_accessor :result

  def initialize
    @finished = false
    @result = 'No result yet'
  end

  class << self
    def init
      players = Player.players_picks_marker
      # puts players
      board = Board.new
      board.print_board
    end
  end
end

class Board
  attr_reader :grid

  def initialize
    @grid = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def print_board
    puts ' %d | %d | %d' % @grid[0..2]
    puts ' %d | %d | %d' % @grid[3..5]
    puts ' %d | %d | %d' % @grid[6..8]
  end
end

class Player
  attr_accessor :marker, :turns

  def initialize(marker)
    @marker = marker
    @turns = 3
  end

  class << self
    def players_picks_marker
      puts 'Player pick your marker: X | O'
      p1_marker = gets
      p2_marker = if p1_marker.chomp == 'X'
                    'O'
                  else
                    'X'
                  end
      p1 = Player.new(p1_marker.chomp)
      p2 = Player.new(p2_marker.chomp)
      first = [p1, p2].sample
      first.turns += 1
      puts 'P1 marker is %s' % p1_marker
      puts 'P2 marker is %s' % p2_marker
      puts '%s Goes first' % first.marker
      [p1, p2]
    end
  end
end

Game.init
