module Slideable
  def moves
    possible_moves = []

    move_dirs.each do |x, y|
      possible_moves += move_until_blocked(x, y)
    end

    possible_moves
  end

  def move_until_blocked(x, y)
    possible_moves = []
    cur_x, cur_y = pos

    while true
      cur_x = cur_x + x
      cur_y = cur_y + y
      pos = [cur_x, cur_y]

      if !board.valid_pos?(pos)
        break
      end

      if board.empty?(pos)
        possible_moves << pos
      else
        if board[pos].color != color
          possible_moves << pos
        end
        break
      end
    end
    possible_moves
  end

  # def move_dirs
  # end
end