# The linear_search method accepts a target number and an array of numbers and
# returns the first number in the array of numbers that matches the provided
# target number.  Returns nil if no match.

def linear_search(number, collection)
  i = 0
  while collection[i]
    if number == collection[i]
      return i
    end
    i += 1
  end

  nil
end

random_numbers = [ 6, 29, 18, 2, 72, 19, 18, 10, 37 ]
p linear_search(18, random_numbers)
# => 2
p linear_search(9, random_numbers)
# => nil

# The global_linear_search method does the same as the linear_search method except
# it will return an array of matching indices.  Returns an empty array if no
# matches are found.

def global_linear_search(letter, collection)
  i = 0
  indices = []

  while collection[i]
    if letter == collection[i]
      indices << i
    end
    i += 1
  end

  indices
end


bananas_arr = "bananas".split(//)
# => ["b", "a", "n", "a", "n", "a", "s"]
p global_linear_search("a", bananas_arr)
# => [ 1, 3, 5 ]