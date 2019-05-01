require_relative "piece"

class Board
  attr_reader :rows
  
  def initialize
    @rows = Array.new(8) { Array.new(8) }

    @rows.each_with_index do |row, i|
      row.each_with_index do |square, j|
        if (2..5).include?(i)
          row[j] = nil
        else
          row[j] = Piece.new
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
  end
end