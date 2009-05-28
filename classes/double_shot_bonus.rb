class DoubleShotBonus < Bonus

  def initialize(window,x,y)
    super
    @img = Gosu::Image.new(@window, "media/double_shot_bonus.png", true)
  end

  private

  def speed
    1
  end

end

