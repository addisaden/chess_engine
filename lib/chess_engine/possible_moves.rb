module ChessEngine
  module PossibleMoves

    def possible_queen_moves(color=self.color)
      # setup
      queen_directions = [-1,0,1].product [-1,0,1]
      queen_directions.delete [0,0]
      current_positions = self.positions
      result = []
      
      directory_steps_helper(queen_directions, :queen, color) do |possible_move|
        yield_result = true

        if current_positions.keys.include? possible_move then
          unless current_positions[possible_move][:color] == color then
            result << "Qx#{ possible_move }"
          end
          yield_result = false
        else
          result << "Q#{ possible_move }"
        end

        yield_result
      end

      return result
    end


    def directory_steps_helper(directions, piece, color=self.color, &block)
      @pieces[color][piece].each do  |piece_history|
        # is piece alive?
        if (current_piece_position = piece_history.last) =~ /^[a-h][1-8]$/ then
          cpp = current_piece_position
          # then run directions.
          directions.each do |direction|
            (1..7).each do |piece_step|
              move_y = piece_step * direction[0]
              move_x = piece_step * direction[1]
              if(relative_piece_position = relative_position(cpp, move_y, move_x)) then
                # THIS IS THE YIELD BLOCK - IF YIELD RETURNS FALSE IT BREAKS THE INNER LOOP !!!
                break unless block.call(relative_piece_position)
              end
            end
          end
        end
      end
    end

  end
end