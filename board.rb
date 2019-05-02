require_relative "piece"

class Board
  attr_reader :grid
  
  def initialize
    @grid = Array.new(8) { Array.new(8) }

    @grid.each_with_index do |row, i|
      row.each_with_index do |square, j|
        if (2..5).include?(i)
          row[j] = nil
        else
          row[j] = Piece.new
        end
      end
    end
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    grid[row][col] = val
  end

  def move_piece(start_pos, end_pos)
    raise NoPieceAtPosition if self[start_pos].nil?
    raise InvalidEndPosition if end_pos.any? { |num| num < 0 }

    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  def valid_pos?(pos)
    row, col = pos

    (0..7).include?(row) && (0..7).include?(col)
  end
end

class NoPieceAtPosition < StandardError
  def message
    "There's no piece at the given start position."
  end
end

class InvalidEndPosition < ArgumentError
  def message
    "Given end position is out of range or otherwise not playable."
  end
end