# Demonstration of scope and instance_eval
class MyClass 
  def initialize
    @v = 1
  end
end

obj = MyClass.new
obj.instance_eval do 
  puts self                   # => #<MyClass:.... @v=1>
  puts @v                     # => 1
end

v = 2
obj.instance_eval { @v = v }  # Can access local variable v in closure
obj.instance_eval { puts @v } # => 2
