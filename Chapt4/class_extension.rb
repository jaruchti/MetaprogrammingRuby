# Demonstration of a class extension with and without using the Object#extend() method

module MyModule
  def my_method; 'hello'; end
end

class MyClass
  class << self 
    # Include MyModule instance methods on the eigenclass of MyClass.
    include MyModule
  end
end

p MyClass.my_method

class MyClass2
  extend MyModule
end
p MyClass.my_method

obj = Object.new
obj.extend MyModule 
p obj.my_method
