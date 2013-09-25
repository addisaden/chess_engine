module ChessEngine
  module Position

    # (for the right color!)
    # +1, 0 = up
    # 0, +1 = right
    # -1, 0 = down
    # -1,-1 = down left
    #
    def relative_position(field_symbol, relative_y, relative_x)
      rows = (1..8).to_a.collect { |r| r.to_s }
      cols = (?a..?h).to_a
      if self.color == COLORS[1]
        rows.reverse!
        cols.reverse!
      end
      current_row = rows.index(field_symbol[1]) # y
      current_col = cols.index(field_symbol[0]) # x
      added_row = current_row + relative_y
      added_col = current_col + relative_x
      if added_row > 8 or added_row < 0 or added_col > 8 or added_col < 0 then
        return nil
      end

      binding.pry

      return "#{ cols[added_col] }#{ rows[added_row] }".to_sym
    end

    def positions
      result = {}

      @pieces.each do |color, pieces|
        pieces.each do |name, piece_positions|
          piece_positions.each do |position_history|

            # threw loops get: color, name, current_position
            if (current_position = position_history.last) =~ /^[a-h][1-8]$/ then
              raise "Position is placed 2 times" if result.has_key?(current_position)
              result[current_position] = { color: color, piece: name }
            end

          end
        end
      end

      return result
    end

  end
end