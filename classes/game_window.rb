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

    @grid = EnemyGrid.new(@width, @height, 6, 15)

    @screen = :game

    double_shot_bonus_event = ScheduledEvent.new(12) do
      DoubleShotBonus.new(self,rand * @width, -10)
    end

    triple_shot_bonus_event = ScheduledEvent.new(20) do
      TripleShotBonus.new(self, rand * width, -10)
    end

    double_speed_bonus_event = ScheduledEvent.new(16) do
      DoubleSpeedBonus.new(self, rand * width, -10)
    end

    @grid.cols.times do |index|
      @grid << NormalEnemy.new(self, @grid.next_available_position)
    end
    @grid.cols.times do |index|
      @grid << FireEnemy.new(self, @grid.next_available_position)
    end
    @grid.cols.times do |index|
      @grid << NormalEnemy.new(self, @grid.next_available_position)
    end
    @grid.cols.times do |index|
      @grid << FireEnemy.new(self, @grid.next_available_position)
    end


    move_enemies_event = ScheduledEvent.new(0.7) do
      Enemy.move_all
    end

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

    ScheduledEvent.call_all

    Bullet.move_all

    Bonus.move_all

    check_collisions

  end

  private

  def check_collisions
    EnemyBullet.all.each do |enemy_bullet|
      if enemy_bullet.collides?(@player) then
        @player.hurt(enemy_bullet.power)
        enemy_bullet.destroy
      end
    end
    PlayerBullet.all.each do |player_bullet|
      Enemy.all.each do |enemy|
        if player_bullet.collides?(enemy) then
          enemy.hurt(player_bullet.power)
          player_bullet.destroy
        end
      end
    end
    Bonus.all.each do |bonus|
      if bonus.collides?(@player) then
        @player.add_bonus(bonus)
        bonus.destroy
      end
    end
  end

end

