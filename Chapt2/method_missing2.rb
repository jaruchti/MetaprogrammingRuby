#Demonstration of utilizing the method_missing hook in Ruby to define new attributes dynamically 
class MyOpenStruct
  def initialize
    @attributes = {}
  end

  def method_missing(name, *args)
    attribute = name.to_s
    if attribute =~ /=$/
      @attributes[attribute.chop] = args[0]
    else
      @attributes[attribute]
    end
  end
end

icecream = MyOpenStruct.new
icecream.flavor = "vanilla"
p icecream.flavor #=> vanilla
