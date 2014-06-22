# Demonstration of defining a class macro (deprecate) in Ruby.

class Example
  def old_method
    puts "Old Method"
  end
  
  def new_method
    puts "New Method"
  end
  
  def self.deprecate(old_method, new_method)
    define_method(old_method) do |*args, &block|
      warn "Warning: #{old_method}() is deprecated.  Use #{new_method}()."
      send(new_method, *args, &block)
    end
  end
  
  deprecate :old_method, :new_method
end

e = Example.new
e.old_method 
