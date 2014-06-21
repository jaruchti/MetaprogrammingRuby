# Example of wrapping a legacy interface via metaprogramming

# Legacy data source interface
# Methods not implemented as this is for demo only
class DS
  def initialize 
  end
  def get_mouse_info(workstation_id)
  end
  def get_keyboard_info(workstation_id)
  end
  def get_cpu_info(workstation_id)
  end
  def get_mouse_price(workstation_id)
  end
  def get_keyboard_price(workstation_id)
  end
  def get_cpu_price(workstation_id)
  end
end

# Computer wraps data source interface.
# It queries the datasource for information pertaining
# to the computer_id given to the constructor
# This solution utilizes the method_missing hook.
class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def method_missing(name, *args)
    # Act as a Dynamic Proxy, forwarding requests to data_source before 
    # invoking Computer-specific code
    super if !respond_to?(name)
    info = @data_source.send("get_#{name}_info", args[0])
    price = @data_source.send("get_#{name}_price", args[0])

    #Show parts $100 or more with an asterisk.
    result = "#{name.to_s.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  #Undefine existing methods to get a "blank slate" for method_missing hook
  #to operate properly. Alternatively, subclass from BasicObject
  instance_methods.each do |m|
    undef_method m unless m.to_s =~ /^__|object_id|method_missing|respond_to?/
  end

  #Fix respond_to? so it works for ghost methods
  def respond_to?(method)
    @data_source.respond_to?("get_#{method}_info") || super
  end
end

c = Computer.new(42, DS.new)
p c.respond_to?(:cpu) #True
p c.respond_to?(:ram) #False
