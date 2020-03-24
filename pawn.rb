require_relative "piece"

class Pawn < Piece
  def symbol
    " ♟ ".colorize(color)
  end

  def moves
    forward + capture
  end

  def first_move?
    if color == :white
      return pos[0] == 6
    else
      return pos[0] == 1
    end
  end

  def move_direction
    color == :white ? -1 : 1
  end

  def forward
    possible_moves = []
    cur_x, cur_y = pos

    one_square = [cur_x + move_direction, cur_y]
    if board.valid_pos?(one_square) && board.empty?(one_square)
      possible_moves << one_square
    end

    two_squares = [cur_x + (move_direction * 2), cur_y]
    if first_move? && board.empty?(two_squares)
      possible_moves << two_squares
    end

    possible_moves
  end

  def capture
    possible_captures = []
    cur_x, cur_y = pos

    capture_dirs = [[move_direction, 1], [move_direction, -1]]

    capture_dirs.each do |x, y|
      capture_attack = [cur_x + x, cur_y + y]
      next if !board.valid_pos?(capture_attack)
      next if board.empty?(capture_attack)

      if board[capture_attack].color != color && board[capture_attack].nil?
        possible_captures << capture_attack
      end
    end
    possible_captures
  end
end