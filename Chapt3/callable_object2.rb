# Demonstration of using methods as callable objects
class MyClass
  def initialize(value)
    @x = value
  end

  def my_method
    @x
  end
end

object = MyClass.new(1)
m = object.method :my_method # Store my_method as a callable object
puts m.call # => 1

# Detach method from its object with Method#unbind, then re-bind it to another object
# of the same class.  
unbound = m.unbind
another_object = MyClass.new(2)
m = unbound.bind(another_object)
puts m.call # => 2
