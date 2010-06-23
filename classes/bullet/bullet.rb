class Bullet
  attr_reader :x, :y, :power
  @@bullets = Array.new
  def initialize(window,x,y,direction = :none)
    @x, @y = x, y
    @width, @height = 3, 6
    @direction = direction
    @window = window
    @power = 1
    @@bullets << self
    @img = nil
  end

  def move
    @y -= speed
    case @direction
    when :left then
      @x -= speed / 2
    when :right then
      @x += speed / 2
    when :none then
    end
    Logger.log("Bullet is on #{@x} - #{@y}",self)
    destroy if @y <= 0
  end

  def draw
    @img.draw(@x,@y,1)
  end

  def destroy
    @@bullets.delete self
    Logger.log("Bullet died",self)
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
    @@bullets.each do |bullet|
      bullet.move
    end
  end

  def self.draw_all
    @@bullets.each do |bonus|
      bonus.draw
    end
  end

  def self.all
    @@bullets
  end

  private

  def speed
    raise NotImplementedError
  end

end

