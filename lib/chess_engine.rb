require "chess_engine/version"
require "chess_engine/constants"
require "chess_engine/helper"
require "chess_engine/position"
require "chess_engine/possible_moves"
require "chess_engine/output"

module ChessEngine
  class Game
    include ChessEngine::Helper
    include ChessEngine::Position
    include ChessEngine::PossibleMoves
    include ChessEngine::Output

    def initialize(plain=false)
      @pieces = {}
      @history = []

      # setup plain pieces
      COLORS.each do |color|
        @pieces[color] = {}
        SHORTNAME.keys.each do |piece|
          @pieces[color][piece] = []
        end
      end

      standard_setup unless plain
    end

    private

    def standard_setup
      # setup pawns
      [COLORS, [2,7]].transpose.each do |color, row|
        (?a..?h).each do |column|
          @pieces[color][:pawn] << ["#{ column }#{ row }".to_sym]
        end
      end

      [COLORS, [1,8]].transpose.each do |color, row|
        # setup king
        @pieces[color][:king] << ["e#{ row }".to_sym]

        # setup queen
        @pieces[color][:queen] << ["d#{ row }".to_sym]

        # setup rest
        { :rook => [?a, ?h], :knight => [?b, ?g], :bishop => [?c, ?f] }.each do |piece, columns|
          columns.each do |column|
            @pieces[color][piece] << ["#{ column }#{ row }".to_sym]
          end
        end
      end
    end
  end
end
