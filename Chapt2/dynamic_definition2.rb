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
# This solution uses Dynamic Methods and Dynamic Dispatch
class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source

    #Define new wrapper methods dynamically
    data_source.methods.grep(/^get_(.*)_info$/) { Computer.define_component $1 }
  end

  def self.define_component(name)
    define_method(name) {
      puts "#{name}"
      # Dynamic dispatch to legacy data source interface
      info = @data_source.send "get_#{name}_info", @id
      price = @data_source.send "get_#{name}_price", @id

      # Show parts $100 or more with an asterisk.
      result = "{name.to_s.capitalize}: #{info} ($#{price})"
      return "* {#result}" if price >= 100
      result
    }
  end
end

c = Computer.new(42, DS.new)
p c.respond_to?(:cpu) #True
p c.respond_to?(:ram) #False
