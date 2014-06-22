# Example showing the difference between instance variables of a class
# and instance variables of that class's objects
class MyClass
  @my_var = 1 # Instance variable of the class

  def self.read; @my_var; end #Accesses instance variable of the class 
  def write; @my_var = 2; end #Accesses instance variable of the class's objects
  def read;  @my_var; end     #Accesses instance variable of the class's objects
end

obj = MyClass.new
obj.write
puts obj.read      # => 2  
puts MyClass.read  # => 1
