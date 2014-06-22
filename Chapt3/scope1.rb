# Demonstration of scope in Ruby.  There are three places
# where a program leaves the previous scope behind and opens
# a new one:
# 1) Class definitions
# 2) Module definitions
# 3) Methods

v1 = 1
class MyClass       # SCOPE GATE: entering class
  v2 = 2
  local_variables   # => ["v2"]

  def my_method     # SCOPE GATE: entering def
    v3 = 3
    local_variables # => ["v3"]
  end               # SCOPE GATE: leaving def

  local_variables   # => ["v2"]
end                 # SCOPE GATE: leaving class

obj = MyClass.new
obj.my_method       # => ["v3"]
obj.my_method       # => ["v3"]
local_variables     # => ["v1", "obj"]
