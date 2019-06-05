puts 'Hello World!'
require './human.rb'
require './Environment.rb'
require 'gosu'

# GameWindow
class GameWindow < Gosu::Window
  def initialize
    super(Environment::SCR_WIDTH, Environment::SCR_HEIGHT, false)
    self.caption = 'Gosu Tutorial Game'
    @human = Human.new('female')
    @human.age = 1
    @human.introduce
  end

  def update
    button_down(@prev_id) if button_down?(@prev_id)
  end

  def draw(*args)
    @human.draw *args
  end

  def button_down(id)
    @prev_id=id
    case id
    when Gosu::KbEscape; close
    when Gosu::KbLeft; @human.turn_left
    when Gosu::KbRight; @human.turn_right
    when Gosu::KbUp; @human.turn_up
    when Gosu::KbDown; @human.turn_down
    end
  end
end

window = GameWindow.new
window.show
