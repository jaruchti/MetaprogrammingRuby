# Demonstration of method_missing hook in Ruby

class Lawyer
  def method_missing(method, *args, &block)
    puts "You called: #{method}(#{args.join(', ')})"
    puts "(You also passed it a block #{block}" if !block.nil?
  end
end

bob = Lawyer.new
bob.lawyer_speak 'a'
bob.talk_simple('b', 'c') do 
  # a block
end
