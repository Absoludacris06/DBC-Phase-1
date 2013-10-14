def fibonacci_iterative(n)
  raise ArgumentError.new("Argument must be a positive integer greater than or equal to zero") unless n >= 0 && n.integer?
  return 0 if n == 0
  total = 1
  second_to_last = 0
  last = 1
  (n-1).times do
    total = second_to_last + last
    second_to_last = last
    last = total
  end
  total
end
 
def fibonacci_recursive(n)
  raise ArgumentError.new("Argument must be a positive integer greater than or equal to zero") unless n >= 0 && n.integer?
  return 0 if n == 0
  return 1 if n == 1
  fibonacci_recursive(n-1) + fibonacci_recursive(n-2)
end