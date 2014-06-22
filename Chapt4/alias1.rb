# Demonstrates the use of the alias keyword
class String
  alias :real_length :length
  
  #Now, redefine length
  def length
    real_length > 5 ? 'long' : 'short'
  end
end

puts "War and Peace".length
puts "War and Peace".real_length
