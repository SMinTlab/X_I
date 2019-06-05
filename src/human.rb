require './element.rb'

# Human class extends Element.
class Human < Element
  attr_reader :age
  def initialize(image)
    super(image)
    self.age = 0
    @parameter.life = 5
    @parameter.health = 100
    @parameter.attack = 1
    @parameter.defense = 1
  end

  def age=(age)
    @parameter.age = age
    @age = age
  end
end
