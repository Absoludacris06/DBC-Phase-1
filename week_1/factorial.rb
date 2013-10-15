# Implement an iterative version of the factorial function
def factorial_iterative(n)
  product = 1
  return product if n <= 0
  until n == 0
    product = product * n
    n -= 1
  end
  product
end
 
# Implement a recursive version of the factorial function
def factorial_recursive(n)
  if n == 0
    1
  else
    n * factorial_recursive(n-1)
  end
end