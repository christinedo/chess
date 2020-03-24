require_relative "piece"
require_relative "pawn"
require_relative "rook"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"
require_relative "null_piece"

class Board
  attr_reader :grid
  
  def initialize
    @grid = Array.new(8) { Array.new(8, NullPiece.instance) }

    fill_grid
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    grid[row][col] = val
  end

  def move_piece(current_player_color, start_pos, end_pos)
    raise "Empty start position!" if empty?(start_pos)

    piece = self[start_pos]
    if !piece.valid_moves.include?(end_pos)
      raise "Can't put or leave your King in check!"
    elsif piece.color != current_player_color
      raise "Can't move a piece that doesn't belong to you."
    elsif !piece.move.include?(end_pos)
      raise "This piece can't move like that!"
    end

    move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]

    self[end_pos] = piece
    self[start_pos] = NullPiece.instance
    piece.pos = end_pos

    nil
  end

  def in_check?(color)
    king_pos = find_king_position(color)
    pieces.any? do |piece|
      piece.color != color && piece.moves.include?(king_pos)
    end
  end

  def checkmate?(color)
    players_pieces = pieces.select { |piece| piece.color == color }
    no_valid_moves = players_pieces.all? { |piece| piece.valid_moves.empty? }
    in_check?(color) && no_valid_moves
  end

  def find_king_position(color)
    pieces.find { |piece| piece.color == color && piece.is_a?(King) }.pos
  end

  def pieces
    @grid.flatten.reject { |piece| piece.is_a? NullPiece }
  end

  def dup
    board_dup = Board.new
    pieces.each do |piece|
      board_dup[piece.pos] = piece.class.new(piece.color, board_dup, piece.pos)
    end
    board_dup
  end

  def valid_pos?(pos)
    row, col = pos
    (0..7).include?(row) && (0..7).include?(col)
  end

  def empty?(pos)
    self[pos].empty?
  end

  def fill_grid
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    @grid.each_with_index do |row, i|
      row.each_with_index do |square, j|
        if (2..5).include?(i)
          row[j] = NullPiece.instance
        elsif i == 6 || i == 1
          color = i == 6 ? "white" : "black"
          row[j] = Pawn.new(color, self, [i, j])
        else
          color = i == 7 ? "white" : "black"
          row[j] = pieces[j].new(color, self, [i, j])
        end
      end
    end
  end
end