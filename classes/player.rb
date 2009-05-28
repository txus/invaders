class Player
  def initialize(window,options = {})
    @window = window
    @lives = 5
    @score = 0
    @width = 25
    @height = 30
    @x = @y = 0
    @perk = DefaultPerk.new
    @last_shot = Gosu::milliseconds

    @image = Gosu::Image.new(@window, "media/ship.png", true)
  end

  def place(x)
    if x.is_a? Fixnum then
      @x = x
    elsif x.is_a? Symbol then
      case x
      when :left:
        @x = 0
        Logger.log 'Player has been placed at left', self
      when :center:
        @x = (@window.width/2) - (@width / 2)
        Logger.log('Player has been placed at center', self)
      when :right:
        @x = @window.width - @width
        Logger.log 'Player has been placed at right', self
      end
    end
    @y = @window.height - Settings.PLAYER_Y_POSITION_FROM_BOTTOM.to_i
  end

  def move(direction)
    case direction
    when :left:
      unless @x <= Settings.PLAYER_MOVING_DISTANCE.to_i then
        @x -= Settings.PLAYER_MOVING_DISTANCE.to_i
        Logger.log("Player has been moved to the left, now being at x=#{@x}", self)
      else
        Logger.log("Player cannot move further to the left",self)
      end
    when :right:
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

private

  def _shoot(type)
    case type
    when :single:
      NormalBullet.new(@window,@x + (@width / 2), @y)
      Logger.log("Shot single bullet", self)
    when :double:
      Logger.log("Shot double bullet", self)
    end
    @last_shot = Gosu::milliseconds
  end

end

