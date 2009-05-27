class Enemy
  attr_reader :x, :y
  @@enemies = Array.new
  def initialize(window,x,y)
    @width, @height = 20,20
    @x, @y = x, y
    @window = window
    @img = nil
    @pattern = nil
    @@enemies << self
  end

  def move
    raise NotImplementedError
  end

  def draw
    @img.draw(@x,@y,1)
  end

  def destroy
    @@enemies.delete self
    Logger.log("Enemy died",self)
  end

  def shoot
    EnemyBullet.new(@window,@x + (@width / 2), @y + @height)
    Logger.log("Enemy shot bullet", self)
  end

  def self.move_all
    @@enemies.each do |enemy|
      enemy.move
    end
  end

  def self.draw_all
    @@enemies.each do |enemy|
      enemy.draw
    end
  end

  def self.all
    @@enemies
  end

  private

  def speed
    raise NotImplementedError
  end

end

