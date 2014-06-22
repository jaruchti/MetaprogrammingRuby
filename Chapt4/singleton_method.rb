# Demonstration of defining a singleton method in Ruby
str = "just a regular string"

def str.title?
  self.upcase == self
end

p str.title? # => false
p str.methods.grep(/title?/) # => ["title?"]
p str.singleton_methods      # => ["title?"]
