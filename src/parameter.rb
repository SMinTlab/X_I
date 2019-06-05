# General parameters have been had all objects in this geme.
class Parameter
  attr_accessor :name, :age, :life, :health, :attack, :defense, :speed
  def initialize
    @age = 0
    @life = 0
    @health = 0
    @attack = 0
    @defense = 0
    @speed = 0
  end
end
