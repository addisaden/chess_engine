require "chess_engine/constants"

module ChessEngine
  module Output
    def to_s
      field_result = {}

      # generate empty fields
      (1..8).each do |row|
        field_result[row.to_s] = {}
        (?a..?h).each do |column|
          field_result[row.to_s][column] = nil
        end
      end

      # push fields to field_result
      @pieces.each do |color, pieces|
        figure_tag = "<%s>"
        figure_tag = ">%s<" if color == :black
        pieces.each do |figure, positions|
          positions.each do |figure_history|
            last_position = figure_history.last.to_s
            if last_position =~ /[a-h][1-8]/ then
              pos_field = field_result[last_position[1]][last_position[0]]
              if pos_field
                raise "ChessEngine::Game#to_s Feld ist schon belegt: #{ last_position } - #{ pos_field }"
              end
              figure_name = SHORTNAME[figure]
              figure_name = '-' if figure_name == :P
              field_result[last_position[1]][last_position[0]] = (figure_tag % figure_name.to_s)
            end
          end
        end
      end

      # generate string
      rows    = (1..8).to_a.collect { |r| r.to_s }
      columns = (?a..?h).to_a
      if @history.count.even? then
        rows.reverse!
      else
        columns.reverse!
      end
      divide_line   = "  " + "+---"*8 + "+\r\n"
      result_string = "    " + columns.join('   ') + "\r\n"
      result_string += divide_line
      rows.each do |row|
        collected_collumns = []
        columns.each do |column|
          collected_collumns << (field_result[row][column] || '   ')
        end
        result_string += "#{ row } |" + collected_collumns.join('|') + "| #{ row }\r\n" + divide_line
      end
      result_string += "    " + columns.join('   ')
      return result_string
    end
  end
end