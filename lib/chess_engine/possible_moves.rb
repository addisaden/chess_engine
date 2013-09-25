module ChessEngine
  module PossibleMoves

    def possible_queen_moves(color=self.color)
      queen_directions = [-1,0,1].product [-1,0,1]
      queen_directions.delete [0,0]
      return possible_direction_moves(queen_directions, :queen, color)
    end

    def possible_king_moves(color=self.color)
      king_directions = [-1,0,1].product [-1,0,1]
      king_directions.delete [0,0]
      return possible_direction_moves(king_directions, :king, color, true)
    end

    # King, Queen, Rook, Bishop - NOT Knight, Pawn
    def possible_direction_moves(directions, piece, color, one_step=false)
      current_positions = self.positions
      result = {}
      short_name = SHORTNAME[piece]

      direction_steps_helper(directions, piece, color) do |current_position, possible_move|
        yield_result = one_step ? false : true

        result[current_position] ||= []

        if current_positions.keys.include? possible_move then
          unless current_positions[possible_move][:color] == color then
            result[current_position] << "#{ short_name }x#{ possible_move }"
          end
          yield_result = false
        else
          result[current_position] << "#{ short_name }#{ possible_move }"
        end

        yield_result # THIS IS IMPORTANT
      end

      return result
    end

    def direction_steps_helper(directions, piece, color=self.color, &block)
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
                break unless block.call(cpp, relative_piece_position)
              end
            end
          end
        end
      end
    end

  end
end