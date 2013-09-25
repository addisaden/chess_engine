module ChessEngine
  module Helper
    def color
      @history.count.even? ? :white : :black
    end
  end
end