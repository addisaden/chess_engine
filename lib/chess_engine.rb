require "chess_engine/version"

module ChessEngine
  class Game
    SHORT = {
      :king => :k,
      :queen => :q,
      :rook => :r,
      :bishop => :b,
      :knight => :n,
      :pawn => :p
    }
    def initialize(clear=false)
      @pieces = {}
      [:black, :white].each do |color|
        @pieces[color] = {}
        SHORT.keys.each do |piece|
          @pieces[color][piece] = []
        end
      end
    end
  end
end
