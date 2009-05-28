class GameWindow < Gosu::Window
  attr_accessor :width, :height, :player
  def initialize(w = 640, h = 480)
    # Set window size and caption
    super(w, h, false, 20)
    @width = w
    @height = h
    self.caption = "Space Invaders 0.1 Beta"

    # Load XML Settings
    Settings.load

    @player = Player.new(self)
    @player.place :center
    @background = Gosu::Image.new(self, "media/menu.png", true)

    a = NormalEnemy.new(self,50,180)

    b = NormalEnemy.new(self,200,190)

    b.shoot

    a.shoot

    @screen = :game

    #bonus_caller = RandomCaller.new(10) do

    #end

  end

  def draw
    @background.draw(0,0,0)
    @player.draw
    Bullet.draw_all
    Enemy.draw_all
    Bonus.draw_all
  end

  def update
    case @screen
      when :game:
        if button_down? Gosu::Button::KbLeft then
          @player.move :left
        elsif button_down? Gosu::Button::KbRight then
          @player.move :right
        elsif button_down? Gosu::Button::KbSpace then
          @player.shoot
        end
      else
    end
    if button_down? Gosu::Button::KbEscape then
      close
    end

    Bullet.move_all
    Enemy.move_all
    Bonus.move_all

    check_collisions

  end

  private

  def check_collisions

  end

end

