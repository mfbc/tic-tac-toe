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
      board = Board.new
      board.print_board
      # BUG when player 2 wins not breaking out of loop
      for i in 0..8 do
        players[i%2].play_turn(board)
        board.print_board
        if players[i%2].win?
          puts "Player %s wins" %players[i%2].marker
          # Break out game TODO
          break
        end
      end
      puts "It's a draw"
    end
  end
end

# Board and grid to play
class Board
  attr_reader :grid

  def initialize
    @grid = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def print_board
    puts ' %s | %s | %s ' % @grid[0..2].map { |e| e.to_s }
    puts ' %s | %s | %s ' % @grid[3..5].map { |e| e.to_s }
    puts ' %s | %s | %s ' % @grid[6..8].map { |e| e.to_s }
  end

  def somewhere_to_play?
    !(@grid & [1, 2, 3, 4, 5, 6, 7, 8, 9]).empty?
  end
end

# Methods to actuate over the board and play the game
class Player
  attr_accessor :marker, :turns, :plays

  def initialize(marker)
    @marker = marker
    @plays = []
    @turns = 4
  end

  def win?
    puts @plays
    WIN.include?(@plays)
  end

  def can_play?
    @turns.positive?
  end

  def a_valid_play?(board, play)
    board.grid[play - 1] == play
  end

  def register_play(board, play, marker)
    @plays << play
    @turns -= 1
    board.grid[play.to_i - 1] = marker
  end

  def play_turn(board)
    # The player can play the turn if has turns left and not winned yet
    if can_play? && !win?
      puts '%s Turn, Where would you like to place your marker?: ' % marker
      until a_valid_play?(board, play = gets.chomp.to_i)
        puts '%s Turn, Please select a valid position: ' % marker
      end
    end
    register_play(board, play, marker)
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
      # puts first.turns
      [p1, p2]
    end
  end
end

Game.init
