# Example of dynamic method definition in Ruby via define_method
class MyClass
  define_method :my_method do |my_arg|
    my_arg * 3
  end
end

obj = MyClass.new
p obj.send(:my_method, 2) # Invoke via send to demo dynamic dispatch
