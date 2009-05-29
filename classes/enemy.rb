class Enemy
  attr_reader :x, :y, :width, :height
  @@enemies = Array.new
  def initialize(window,x_y)
    @width, @height = 20,20
    @x, @y = x_y[0], x_y[1]
    @window = window
    @img = nil
    @pattern = nil
    @facing = nil
    @health = 1
    @shooting_event = ScheduledEvent.new(rand * 100) do
      shoot
    end
    @@enemies << self
  end

  def move
    case @facing
    when :right
      @x -= movement
      @facing = :left
    when :left
      @x += movement
      @facing = :right
    end
  end

  def draw
    @img.draw(@x,@y,1)
  end

  def destroy
    @shooting_event.destroy
    @@enemies.delete self
    Logger.log("Enemy died",self)
  end

  def shoot
    EnemyBullet.new(@window,@x + (@width / 2), @y + @height)
    Logger.log("Enemy shot bullet", self)
  end

  def hurt(damage)
    @health -= damage
    destroy if @health <= 0
  end

  def warn

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

