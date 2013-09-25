module ChessEngine
  module PossibleMoves
    
    def possible_queen_move(color=self.color)
      # setup
      current_positions = self.positions
      result = []

      # run threw all queens (yes, somtimes there are more than just one queen)
      @pieces[color][:queen].each do |queen_history|
        if (current_queen_position = queen_history.last) =~ /^[a-h][1-8]$/ then
          #shorthand
          cqp = current_queen_position

          # check the steps
          [-1,0,1].product([-1,0,1]).each do |direction|
            (1..7).each do |queen_step|
              move_y = queen_step * direction[0]
              move_x = queen_step * direction[1]
              if(relative_queen_position = relative_position(cqp, move_y, move_x)) then

                # is field set with another piece?
                if current_positions.keys.include? relative_queen_position then
                  unless current_positions[relative_queen_position][:color] == color then
                    result << "Qx#{ relative_queen_position }"
                  end
                  break
                else
                  result << "Q#{ relative_queen_position}"
                end

              end
            end
          end

          return result
        end
      end
    end

  end
end