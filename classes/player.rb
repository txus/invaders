class Player
  attr_accessor :width, :height, :x, :y, :score
  def initialize(window,options = {})
    @window = window
    @lives = 5
    @score = 0
    @width = 25
    @height = 30
    @x = @y = 0
    @health = 2

    @perk = DefaultPerk.new
    @old_perk = @perk
    @last_shot = Gosu::milliseconds

    @image = Gosu::Image.new(@window, "media/ship.png", true)
  end

  def place(x)
    if x.is_a? Fixnum then
      @x = x
    elsif x.is_a? Symbol then
      case x
      when :left then
        @x = 0
        Logger.log 'Player has been placed at left', self
      when :center then
        @x = (@window.width/2) - (@width / 2)
        Logger.log('Player has been placed at center', self)
      when :right then
        @x = @window.width - @width
        Logger.log 'Player has been placed at right', self
      end
    end
    @y = @window.height - Settings.PLAYER_Y_POSITION_FROM_BOTTOM.to_i
  end

  def move(direction)
    case direction
    when :left then
      unless @x <= Settings.PLAYER_MOVING_DISTANCE.to_i then
        @x -= Settings.PLAYER_MOVING_DISTANCE.to_i
        Logger.log("Player has been moved to the left, now being at x=#{@x}", self)
      else
        Logger.log("Player cannot move further to the left",self)
      end
    when :right then
      unless @window.width - @x <= Settings.PLAYER_MOVING_DISTANCE.to_i then
        @x += Settings.PLAYER_MOVING_DISTANCE.to_i
        Logger.log("Player has been moved to the right, now being at x=#{@x}", self)
      else
        Logger.log("Player cannot move further to the right",self)
      end
    end
  end

  def shoot
    _shoot(@perk.shot_type) unless (Gosu::milliseconds - @last_shot) < @perk.shooting_interval
  end

  def draw
    @image.draw(@x,@y,1)
  end

  def die
    puts "DIED"
    @window.close
  end

  def hurt(damage)
    @health -= damage
    puts "HURT"
    die if @health <= 0
  end

  def add_bonus(bonus)
    @old_perk = @perk
    @perk = bonus.perk.new
    _perk_wear_off_after(bonus.duration)
  end
  
  def remove_bonus
    @perk = @old_perk
  end
  def reset_all_perks
    @perk = DefaultPerk.new
  end

  def score(points)
    @score += points
    puts "Scored #{points}!"
  end

  def warn

  end

private

  def _shoot(type)
    case type
    when :single then
      NormalBullet.new(@window,@x + (@width / 2), @y)
      Logger.log("Shot single bullet", self)
    when :double then
      NormalBullet.new(@window,@x + (@width / 3), @y)
      NormalBullet.new(@window,(@x + @width) - (@width / 3), @y)
      Logger.log("Shot double bullet", self)
    when :triple then
      NormalBullet.new(@window,@x + (@width / 4), @y, :left)
      NormalBullet.new(@window,@x + (@width / 2), @y)
      NormalBullet.new(@window,(@x + @width) - (@width / 4), @y, :right)
      Logger.log("Shot triple bullet", self)
    end
    @last_shot = Gosu::milliseconds
  end
  
  def _perk_wear_off_after(seconds)
    e = ScheduledEvent.new(seconds) do
      reset_all_perks
      e.destroy
    end
    
  end

end

