def binary_search(target, collection)
  @target = target
  @collection = collection.sort
  pos_compare(0, collection.length - 1)
end

def pos_compare(low, high)
  guess = (low + high) / 2
  if @collection[guess] == @target
    return guess
  elsif @collection[guess] != @target && low >= high
    return -1
  elsif @collection[guess] > @target
    pos_compare(low, guess - 1)
  else
    pos_compare(guess + 1, high)
  end
end

test_array = (100..200).to_a
puts binary_search(135, test_array) == 35
# => true

test_array = [13, 19,  24,  29,  32,  37,  43]
puts binary_search(35, test_array) == -1
# => true