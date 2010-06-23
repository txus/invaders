class EnemyGrid
  attr_accessor :table, :rows, :cols
  @@levels = Hash.new
  def initialize(window,w,h,rows,cols, options = {})
    defaults = {:x_padding => 40, :y_padding => 30}
    defaults.merge options
    @window = window
    @x, @y = defaults[:x_padding], defaults[:y_padding]
    @width = w - (defaults[:x_padding] * 2)
    @height = (h - defaults[:y_padding]) * 0.5
    @rows, @cols = rows, cols
    
    @cell_width = @width / cols
    @cell_height = @height / rows

    @level = 0
    @@levels = parse_levels "levels.grd"
    set_grid_for_level Settings.START_LEVEL.to_i


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

  def set_grid_for_level(num)
    @level = num
    reset_table
    @@levels[num][:grid].each_with_index do |row,rindex|
      row.each_with_index do |col,cindex|
        position = [@x + (cindex * @cell_width), @y + (rindex * @cell_height)]
        @table[rindex][cindex] = eval(Settings.send(col) + '.new(@window, position)') if col
      end
    end
    show
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
        puts column
        if column.nil? then
          free_cell = true
          return [@x + (cindex * @cell_width), @y + (rindex * @cell_height)]
        end
      end
    end
    raise NoFreeCellException if free_cell == false
  end
  
  private
  
  def reset_table
    @rows = @@levels[@level][:rows]
    @cols = @@levels[@level][:cols]
    
    @cell_width = @width / cols
    @cell_height = @height / rows
    
    @table = Array.new(@rows)
    @table.each_with_index do |row,rindex|
      @table[rindex] = Array.new(@cols)
    end
    #@table.each_with_index do |row, rindex|
    #  row.each_with_index do |column, cindex|
    #    if not column.nil? and column.is_a? Enemy then
    #      column.destroy
    #      column = nil
    #    end
    #  end
    #end
  end
  
  def parse_levels(filename)
    f = File.open(filename, "r")
    lvl = nil
    rows = cols = 0
    arr = Hash.new
    level = Array.new
    f.each do |line|
      if line.match /Level (\d+)/ then
        lvl = $1
        level = Array.new
        rows = cols = 0
      end
      if line.match /(n|f)+/ then
        types = Array.new
        rows += 1
        chars = line.split(" ")
        cols = chars.length unless chars.length < cols
        chars.each_with_index do |ch, index|
          case ch
          when '0' then
            types << nil
          else
            types << ch
          end
        end
        level << types
      end
      arr[lvl.to_i] = {:grid => level, :cols => cols, :rows => rows}
    end
    return arr
  end

end

