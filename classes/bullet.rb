class Bullet
  attr_reader :x, :y
  @@bullets = Array.new
  def initialize(window,x,y)
    @x, @y = x, y
    @window = window
    @@bullets << self
    @img = nil
  end

  def move
    @y -= speed
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

