# Demonstration of safe levels/taintedness in Ruby.
# String evaluation is potentially dangerous due to code injection attacks.
# Safe levels/taintedness help to limit this.

$SAFE = 2
user_input = gets()

p user_input.tainted? # All user input marks the object as tainted
user_input.untaint    # Untaint the object (potentially dangerous)

p eval(user_input)    #Eval user input at safety level 2 (disallows most File operations)
