require "chess_engine/constants"

module ChessEngine
  module Position
    def positions
      result = {}
      @pieces.each do |color, pieces|
        pieces.each do |name, piece_positions|
          piece_positions.each do |position|
            if position.last =~ /^[a-h][1-8]$/ then
              last_position = position.last
              raise "Position is placed 2 times" if result.has_key?(last_position)
              result[last_position] = { color: color, piece: name }
            end
          end
        end
      end
      return result
    end
  end
end