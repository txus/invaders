require 'rubygems'
require 'gosu'
require 'rexml/document'

require 'classes/exceptions'
require 'classes/player'
require 'classes/settings'
require 'classes/game_window'
require 'classes/logger'
require 'classes/enemy_grid'
require 'classes/score'

require 'classes/event/event'
require 'classes/event/random_event'
require 'classes/event/scheduled_event'

require 'classes/perk/perk'
require 'classes/perk/default_perk'
require 'classes/perk/double_shot_perk'
require 'classes/perk/triple_shot_perk'
require 'classes/perk/double_speed_perk'

require 'classes/bullet/bullet'
require 'classes/bullet/enemy_bullet'
require 'classes/bullet/enemy_fire_bullet'
require 'classes/bullet/player_bullet'
require 'classes/bullet/normal_bullet'

require 'classes/enemy/enemy'
require 'classes/enemy/normal_enemy'
require 'classes/enemy/fire_enemy'

require 'classes/bonus/bonus'
require 'classes/bonus/double_shot_bonus'
require 'classes/bonus/triple_shot_bonus'
require 'classes/bonus/double_speed_bonus'

window = GameWindow.new

window.show

