class DoubleSpeedBonus < Bonus

  def initialize(window,x,y)
    super
    @img = Gosu::Image.new(@window, "media/double_speed_bonus.png", true)
    @perk = DoubleSpeedPerk
  end

  private

  def speed
    2
  end

end

