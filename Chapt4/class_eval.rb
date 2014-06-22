# Demonstration of using class eval to open a class and define a new method
def add_method_to(a_class)
  a_class.class_eval do 
    def m; 'Hello!'; end
  end
end

# Very contrived example of adding new method to String
# using class_eval
add_method_to String
puts "abc".m        # => "Hello!"
