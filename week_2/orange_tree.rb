class NoOrangesError < StandardError
end
 
class OrangeTree
 
  attr_reader :number_of_oranges
  MATURE = 5
  DEAD = 15
 
  def initialize
    @number_of_oranges = 0
  end

  def age!
    @age ||= 0
    @age += 1
    if @age >= MATURE && @age < DEAD
      @number_of_oranges += 5
    end
  end
 
  def age
    @age ||= 0
  end
 
  def dead?
    @age >= DEAD
  end 
 
  def any_oranges?
    MATURE <= @age && @age < DEAD && @number_of_oranges > 0
  end
 
  def pick_an_orange!
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?
    @number_of_oranges -= 1
    p "You picked an orange"
    Orange.new
  end
 
end
 
class Orange
 
  MAX_DIA = 4
  MIN_DIA = 2
  attr_reader :diameter
 
  def initialize
    @diameter = rand * (MAX_DIA - MIN_DIA) + MIN_DIA
  end
 
end
 
new_tree = OrangeTree.new
new_tree.age!
p new_tree.age
new_tree.age!
p new_tree.age
new_tree.age!
p new_tree.age
new_tree.age!
p new_tree.age
p new_tree.any_oranges?
new_tree.age!
p new_tree.any_oranges?
p new_tree.number_of_oranges
fresh_orange = new_tree.pick_an_orange!
p new_tree.number_of_oranges
p fresh_orange.diameter
until new_tree.age > 15
  new_tree.age!
end
p new_tree.age
p new_tree.dead?