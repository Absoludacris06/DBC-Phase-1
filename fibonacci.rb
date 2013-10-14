def fibonacci_iterative(n)
  return 0 if n == 1
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
  return 0 if n == 0
  return 1 if n == 1
  fibonacci_recursive(n-1) + fibonacci_recursive(n-2)
end