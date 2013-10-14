# Method for finding proper sequence for a series of actors based on Samuel
# Beckett's play Quad.

# http://en.wikipedia.org/wiki/Quad_(play)

# Arguments: 
#   +actors+ is an arbitrary array of unique elements, representing
#   the totality of actors that could possibly appear on stage
#
# Return values:
#   Returns an +Array+ of +Arrays+, each of which represents 
#   the set of actors on stage at each moment in time
#
# Rules:
#   1. Each subset of actors, including the "empty" set, should appear
#      in the returned array once and exactly once
#
#   2. Each consecutive set of actors should differ by *either*
#      the removal or addition of a single actor, representing
#      that actor entering or exiting the stage, respectively
 
 
def beckett_directions(actors)
  @actors = actors
  beckett_builder(@actors.length)
end
 
def beckett_builder(n)
  if n == 1
    return [ [], [@actors[0]] ]
  else
    first_array = beckett_builder(n - 1)
    build_array = Marshal.load(Marshal.dump(first_array))
    build_array.reverse!
    build_array.length.times do |i|
      build_array[i] << @actors[n - 1]
    end
    return first_array + build_array
  end
end
 
# The play "ends" when the last remaining actor is on stage, so that actor never exits
p beckett_directions(['red'])
  # => [[], ['red']]
 
# The play ends when "elaine" is the last actor on the stage
p beckett_directions(['jasper', 'elaine'])
  # => [[], ['jasper'], ['jasper', 'elaine'], ['elaine']]
 
# The play ends when "melon" is the last actor on the stage
p beckett_directions(['apple', 'pear', 'melon'])
   # => [[],
   #     ['apple'],
   #     ['apple', 'pear'],
   #     ['pear'],
   #     ['pear', 'melon'],
   #     ['apple', 'pear', 'melon'],
   #     ['apple', 'melon'],
   #     ['melon']]