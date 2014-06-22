# Creation of a domain specific language in Ruby.

# In seperate (*events.rb) files, events are defined as follows:
# event "event_name" { block of code to execute }
# These files are read into this program and executed.
# If the block returns true, an alert with the event
# name is given. For instance, the below 
# event "an event that always happens" do 
#   true
# end 
# will generate "ALERT: an event that always happens"
# when read by this program.
# Additionally, before each event setup is performed.
# Setup is defined as follows
# setup { block of code to execute }

lambda {
  setups = []
  events = {}

  # event(name) Stores code blocks associated with each event loaded from the file
  Kernel.send :define_method, :event do |name, &block|
    events[name] = block
  end

  # setup() Stores code blocks associated with each setup loaded from the file
  Kernel.send :define_method, :setup do |&block|
    setups << block
  end

  # each_event() Executes the block given on each event
  Kernel.send :define_method, :each_event do |&block|
    events.each_pair do |name, event|
      block.call name, event
    end
  end

  # each_setup() Exucutes the block given on each setup
  Kernel.send :define_method, :each_setup do |&block|
    setups.each do |setup|
      block.call setup
    end
  end
}.call

Dir.glob('*events.rb').each do |file|
  # Load the *events.rb file.
  # Since we use load, each event/setup label found will actually 
  # call the corresponding event/setup method defined in the lambda
  # above.
  load file

  each_event do |name, event|
    env = Object.new  # Create a clean area to execute the setup/event blocks

    # Execute each setup block in the context of this clean slate object
    each_setup do |setup|
      env.instance_eval &setup
    end

    # Execute each event block in the context of this clean slate object.
    # Generate an alert if the block evaluates to true
    puts "ALERT: #{name}" if env.instance_eval &event
  end
end
