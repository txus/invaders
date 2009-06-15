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
    @shooting_seconds = 30
    @shooting_chance = 0.2
    renew_shooting_pattern
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

  def approach(distance)
    @y += distance
  end

  def draw
    @img.draw(@x,@y,1)
  end

  def destroy
    @shooting_event.destroy
    @shooting_event = nil
    @@enemies.delete self
    Logger.log("Enemy died",self)
  end

  def shoot
    EnemyBullet.new(@window,@x + (@width / 2), @y + @height)
    Logger.log("Enemy shot bullet", self)
  end

  def renew_shooting_pattern
    @shooting_event.destroy if @shooting_event.is_a? Event
    @shooting_event = RandomEvent.new(rand * @shooting_seconds, @shooting_chance) do
      shoot
    end
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

