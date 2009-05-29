class Bonus
  attr_reader :x, :y, :perk
  @@bonuses = Array.new
  def initialize(window,x,y)
    @x, @y = x, y
    @window = window
    @perk = nil
    @@bonuses << self
  end

  def move
    @y += speed
    Logger.log("Bonus is on #{@x} - #{@y}",self)
    destroy if @x <= 0
  end

  def draw
    @img.draw(@x,@y,1)
  end

  def destroy
    @@bonuses.delete self
    Logger.log("Bonus died",self)
  end

  def collides?(player)
    if @x >= player.x and @x <= player.x + player.width then
      player.warn
      if @y >= player.y and @y <= player.y + player.height then
        true
      end
    else
      false
    end
  end

  def self.move_all
    @@bonuses.each do |bonus|
      bonus.move
    end
  end

  def self.draw_all
    @@bonuses.each do |bonus|
      bonus.draw
    end
  end

  def self.all
    @@bonuses
  end

  private

  def speed
    raise NotImplementedError
  end

end

