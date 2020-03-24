require "colorize"
require_relative "board"
require_relative "cursor"

class Display
  attr_reader :board, :notifications, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
    @notifications = {}
  end

  def render
    system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."

    render_grid

    @notifications.each do |_key, val|
      puts val
    end
  end

  def render_grid
    x, y = @cursor.cursor_pos
    chess_board = @board.grid
    chess_board.each_with_index do |row, i|
      print_row = row.map.with_index do |square, j|
        if x == i && y == j
          color = @cursor.selected ? :green : :yellow
          square.to_s.colorize(:background => color)
        elsif i.even? && j.even? || i.odd? && j.odd?
          square.to_s.colorize(:background => :blue)
        else
          square.to_s.colorize(:background => :red)
        end
      end
      puts print_row.join
    end
  end

  def reset!
    @notifications.delete(:error)
  end

  def uncheck!
    @notifications.delete(:check)
  end

  def set_check!
    @notifications[:check] = "Check!"
  end
end