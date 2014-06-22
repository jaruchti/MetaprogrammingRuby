# Redefine an method using the existing implementation with aliases.

# Contrived example of redefining + so that it
# returns the correct answer +1
class Fixnum
  alias :old_plus :+

  def +(value)
    self.old_plus(value).old_plus(1)
  end
end

p "1 + 1 = #{1+1}" # => 3
