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
      self.positions.each do |position, value|
        color = value[:color]
        piece = value[:piece]
        piece_tag = "<%s>"
        piece_tag = ">%s<" if color == COLORS[1]
        if current_field = field_result[position[1]][position[0]] then
          raise "ChessEngine::Game#to_s - Feld ist schon belegt: #{ position } - #{ current_field }"
        end
        piece_name = SHORTNAME[piece]
        piece_name = '-' if piece_name == :P
        field_result[position[1]][position[0]] = (piece_tag % piece_name)
      end

      # generate string
      rows    = (1..8).to_a.collect { |r| r.to_s }
      columns = (?a..?h).to_a

      # - bring rows and cols in the right position for color
      if self.color == COLORS[0] then
        rows.reverse!
      else
        columns.reverse!
      end

      # - create head
      divide_line   = "  " + "+---"*8 + "+\r\n"
      result_string = "    " + columns.join('   ') + "\r\n"
      result_string += divide_line

      # - iterate over gamelines
      rows.each do |row|
        collected_collumns = []
        columns.each do |column|
          collected_collumns << (field_result[row][column] || '   ')
        end
        result_string += "#{ row } |" + collected_collumns.join('|') + "| #{ row }\r\n" + divide_line
      end

      # last column description (a..h)
      result_string += "    " + columns.join('   ')
      
      return result_string
    end
  end
end