require "chess_engine/constants"

module ChessEngine
  module Position


    def relative_position(field_symbol, relative_y, relative_x)
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