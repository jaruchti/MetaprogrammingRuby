# Demonstration of callable objects in Ruby - converting a block to a proc and vice-versa
# via the & operator.

def math(a, b)
  yield(a, b)
end

def teach_math(a, b, &operation) # Block to Proc
  puts "Lets do the math:"
  puts math(a, b, &operation) # Proc to block
end

teach_math(2, 3) { |x, y| x * y }
# Let's do the math:
# 6
