# Demonstration of the included hook in Ruby
module M
  def self.included(othermod)
    puts "M was mixed into #{othermod}"
  end
end

class C
  include M
end
