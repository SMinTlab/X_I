require './parameter.rb'
require './Environment.rb'
require './Direction.rb'
# Top level of object in this game.
class Element
  def initialize(name)
    @rendering = false
    @img = []
    @img[Direction::DOWN]= []
    @img[Direction::LEFT]= []
    @img[Direction::RIGHT]= []
    @img[Direction::UP]= []
    walk_idx = [0,1,0,2]
    @img.each_with_index do |x,i|
      walk_idx.map{|j| x.push(Gosu::Image.new(Environment::Asset + name + '/' + name + '_' + (3*i+j).to_s() + '.png', tileable: true))}
    end
    @dir = Direction::DOWN
    @finish_callback = nil
    @index = 0
    @parameter = Parameter.new
    @parameter.life = 1
    @parameter.health = 1
    @parameter.speed = 
    @x = Environment::WIDTH / 2
    @y = Environment::HEIGHT / 2
  end

  def introduce
    str = '=' * 20 << "\nClass: #{self.class.name}\n"
    params = %w[name age life health attack defense]
    params.each do |s|
      str << "#{s}: #{@parameter.send(s)}\n"
    end
    str << '=' * 20
    puts str
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    if !@rendering
      @dir = Direction::LEFT
      @rendering =true
      callback = ->(){
        puts 'callback'
        @rendering =false
      }
      self.once(&callback)
    end
  end

  def turn_right
    if !@rendering
      @dir = Direction::RIGHT
      @rendering =true
      callback = ->(){
        puts 'callback'
        @rendering =false
      }
      self.once(&callback)
    end
  end

  def turn_up
    if !@rendering
      @dir = Direction::UP
      @rendering =true
      callback = ->(){
        puts 'callback'
        @rendering =false
      }
      self.once(&callback)
    end
  end

  def turn_down
    if !@rendering
      @dir = Direction::DOWN
      @rendering =true
      callback = ->(){
        puts 'callback'
        @rendering =false
      }
      self.once(&callback)
    end
  end

  def draw(*args)
    current_img.draw(@x,@y,0)
  end

  def once(&callback)
    @index = nil
    @last_time = nil
    @finish_callback = callback
  end

private

  def current_img
    @last_time ||= Gosu.milliseconds
    @index ||= 0
    @dir ||= 0
    next_img if Gosu.milliseconds - @last_time > 90 && @finish_callback
    @img[@dir][@index]
  end

  def next_img
    move
    @last_time = Gosu.milliseconds
    @index += 1
    @index = 0 if @index > @img[@dir].size - 1
    if @index == 0 && @finish_callback
      @finish_callback.call
      @finish_callback = nil
    end
  end

  def move
    case @dir
      when Direction::DOWN; @y+=5
      when Direction::LEFT; @x-=5
      when Direction::RIGHT; @x+=5
      when Direction::UP; @y-=5
      else nil
    end
    @y=edge_y(@y)
    @x=edge_x(@x)
  end

  def edge_x(x)
    if x < 0
      val = Environment::SCR_WIDTH - Environment::WIDTH / 2
    elsif x + Environment::WIDTH / 2 > Environment::SCR_WIDTH
      val = Environment::WIDTH / 2
    else
      val = x
    end
  end

  def edge_y(y)
    if y < 0
      val = Environment::SCR_HEIGHT - Environment::HEIGHT / 2
    elsif y + Environment::HEIGHT / 2 > Environment::SCR_HEIGHT
      val = Environment::HEIGHT / 2
    else
      val = y
    end
  end

end