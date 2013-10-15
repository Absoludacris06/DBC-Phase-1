# Orange tree exercise.  Beginning of OOP.

class NoOrangesError < StandardError
end

class OrangeTree

  attr_reader :number_of_oranges, :height
  MATURE = 5
  DEAD = 15

  def initialize
    @number_of_oranges = 0
    @height = 3
  end

  def age!
    @age += 1
    @height += 1
    if age >= MATURE && !self.dead?
      @number_of_oranges += (20..40).to_a.sample
    end
  end

  def age
    @age ||= 0
  end

  def dead?
    age >= DEAD
  end

  def any_oranges?
    age < DEAD && @number_of_oranges > 0
  end

  def pick_an_orange!
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?
    @number_of_oranges -= 1
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

tree = OrangeTree.new

tree.age! until tree.any_oranges?

puts "Tree is #{tree.age} years old and #{tree.height} feet tall"

until tree.dead?
  basket = []

  while tree.any_oranges?
    basket << tree.pick_an_orange!
  end

  avg_diameter = basket.inject(0) { |sum, orange| sum + orange.diameter } / basket.size

  puts "Year #{tree.age} Report"
  puts "Tree height: #{tree.height} feet"
  puts "Harvest:     #{basket.size} oranges with an average diameter of #{avg_diameter.round(2)} inches"
  puts ""

  tree.age!
end

puts "Alas, the tree, she is dead!"