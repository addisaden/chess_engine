require "chess_engine/constants"

module ChessEngine
  module Helper
    def color
      @history.count.even? ? COLORS[0] : COLORS[1]
    end
  end
end