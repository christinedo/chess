require_relative "piece"
require_relative "slideable"

class Queen < Piece
  include Slideable

  def symbol
    " ♛ ".colorize(color)
  end

  def move_dirs
    [
      [1, -1],
      [-1, -1],
      [-1, 1],
      [1, 1],
      [0, -1],
      [-1, 0],
      [0, 1],
      [1, 0]
    ]
  end
end