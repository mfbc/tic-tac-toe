WIN = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

# Main Event to handle
class Game
  class << self
    def init
      result = 'It is a draw!'
      players = Player.players_picks_marker
      board = Board.new
      board.print_board
      alternate_turns = 1
      while board.somewhere_to_play?
        if alternate_turns == 1
          players[0].play_turn(board)
          if players[0].win?
            result = '%s Wins' % players[0].marker
            break
          end
        else
          players[1].play_turn(board)
          if players[1].win?
            result = '%s Wins' % players[1].marker
            break
          end
        end
        alternate_turns = -alternate_turns
      end
      puts result
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

  def available_space
    (@grid & [1, 2, 3, 4, 5, 6, 7, 8, 9]).count
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
    if can_play?
      puts '%s Turn, Where would you like to place your marker?: ' % marker
      until a_valid_play?(board, play = gets.chomp.to_i)
        puts '%s Turn, Please select a valid position: ' % marker
      end
    end
    register_play(board, play, marker)
    board.print_board
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
      if first == p1
        [p1, p2]
      else
        [p2, p1]
      end
    end
  end
end

Game.init
