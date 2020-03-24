class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color.to_sym
    @board = board
    @pos = pos
  end

  def to_s
    "#{symbol}"
  end

  def empty?
    false
  end

  def symbol
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    board_copy = board.dup
    board_copy.move_piece!(pos, end_pos)
    board_copy.in_check?(color)
  end
end