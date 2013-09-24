require "chess_engine/version"

module ChessEngine
  class Game
    # with .invert you can switch key and value
    SHORTNAME = {
      :king => :k,
      :queen => :q,
      :rook => :r,
      :bishop => :b,
      :knight => :n,
      :pawn => :p
    }

    def initialize(plain=false)
      @pieces = {}
      @history = []

      # setup plain pieces
      [:black, :white].each do |color|
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
      { :black => 7, :white => 2 }.each do |color, row|
        (?a..?h).each do |column|
          @pieces[color][:pawn] << ["#{ column }#{ row }".to_sym]
        end
      end

      { :black => 8, :white => 1 }.each do |color, row|
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
