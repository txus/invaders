class EnemyGrid
  attr_accessor :table, :rows, :cols
  def initialize(w,h,rows,cols, options = {})
    defaults = {:x_padding => 40, :y_padding => 30}
    defaults.merge options
    @x, @y = defaults[:x_padding], defaults[:y_padding]
    @width = w - (defaults[:x_padding] * 2)
    @height = (h - defaults[:y_padding]) * 0.5
    @rows, @cols = rows, cols

    @cell_width = @width / cols
    @cell_height = @height / rows

    @table = Array.new(rows)
    @table.each_with_index do |row,rindex|
      @table[rindex] = Array.new(cols)
    end

  end

  def <<(enemy)
    @table.each_with_index do |row, rindex|
      row.each_with_index do |column, cindex|
        if column.nil? then
          @table[rindex][cindex] = enemy
          return
        end
      end
    end
  end

  def distribution=(array)

  end

  def show
    out = ""
    @table.each_with_index do |row, rindex|
      out += "#{rindex} | "
      row.each_with_index do |column, cindex|
        if @table[rindex][cindex].nil? then
          out += "  | "
        else
          out += "x | "
        end
      end
      out += "\n"
    end
    puts out
  end

  def next_available_position
    free_cell = false
    @table.each_with_index do |row, rindex|
      row.each_with_index do |column, cindex|
        if column.nil? then
          free_cell = true
          return [@x + (cindex * @cell_width), @y + (rindex * @cell_height)]
        end
      end
    end
    raise NoFreeCellException if free_cell == false
  end

end

