require "colorize"

require_relative "board"
require_relative "cursor"

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    x, y = @cursor.cursor_pos
    chess_board = @board.grid
    chess_board.each_with_index do |row, i|
      print_row = row.map.with_index do |square, j|
        if x == i && y == j
          "C".colorize(:green)
        elsif square.nil?
          "-".colorize(:light_blue)
        else
          "X".colorize(:light_magenta)
        end
      end
      puts print_row.join(" ")
    end
  end

  def test_cursor
    while true
      render
      @cursor.get_input
      system("clear")
    end
  end
end

b = Board.new
d = Display.new(b)
d.test_cursor