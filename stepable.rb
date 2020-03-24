module Stepable
  def moves
    possible_moves = []
    cur_x, cur_y = pos

    move_dirs.each do |x, y|
      pos = [cur_x + x, cur_y + y]
      if board.valid_pos?(pos)
        if board.empty?(pos)
          possible_moves << pos
        elsif board[pos].color != color
          possible_moves << pos
        end
      end
    end

    possible_moves
  end
end