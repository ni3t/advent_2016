=begin
--- Day 1: No Time for a Taxicab ---
Santa's sleigh uses a very high-precision clock to guide its movements, and the clock's oscillator 
is regulated by stars. Unfortunately, the stars have been stolen... by the Easter Bunny. 
To save Christmas, Santa needs you to retrieve all fifty stars by December 25th.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the advent 
calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one 
star. Good luck!

You're airdropped near Easter Bunny Headquarters in a city somewhere. "Near", unfortunately, 
is as close as you can get - the instructions on the Easter Bunny Recruiting Document the Elves 
intercepted start here, and nobody had time to work them out further.

The Document indicates that you should start at the given coordinates (where you just landed) 
and face North. Then, follow the provided sequence: either turn left (L) or right (R) 90 degrees, 
then walk forward the given number of blocks, ending at a new intersection.

There's no time to follow such ridiculous instructions on foot, though, so you take a moment and 
work out the destination. Given that you can only walk on the street grid of the city, 
how far is the shortest path to the destination?

For example:

Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks away.
R2, R2, R2 leaves you 2 blocks due South of your starting position, which is 2 blocks away.
R5, L5, R5, R3 leaves you 12 blocks away.
How many blocks away is Easter Bunny HQ?


=end

test1 = <<EOS
R5, L5, R5, R3
EOS

input = (ARGV.delete("-t") ? test1 : DATA).each_line.first.split(", ").map(&:strip)
pointing = 0
x, y = 0, 0
part2 = nil
visited = [[0, 0]]
input.each do |instruction|
  dir, *amt = instruction.chars
  amt = amt.join.to_i
  # turn
  if dir == ?R
    pointing = (pointing + 1) % 4
  else
    pointing = (pointing - 1) % 4
  end
  # travel
  if pointing == 0
    old_y = y
    y += amt
    path = (old_y + 1..y).map { |yv| [x, yv] }
    path.each do |c|
      if visited.include?(c)
        if part2.nil?
          part2 = c
        end
      end
    end
    visited = visited.concat(path)
  elsif pointing == 1
    old_x = x
    x += amt
    path = (old_x + 1..x).map { |xv| [xv, y] }
    path.each do |c|
      if visited.include?(c)
        if part2.nil?
          part2 = c
        end
      end
    end
    visited = visited.concat(path)
  elsif pointing == 2
    old_y = y
    y -= amt
    path = (y..old_y - 1).map { |yv| [x, yv] }
    path.each do |c|
      if visited.include?(c)
        if part2.nil?
          part2 = c
        end
      end
    end
    visited = visited.concat(
      path
    )
  else
    old_x = x
    x -= amt
    path = (x..old_x - 1).map { |xv| [xv, y] }
    path.each do |c|
      if visited.include?(c)
        if part2.nil?
          part2 = c
        end
      end
    end
    visited = visited.concat(
      path
    )
  end
end

puts x + y
puts [*part2].map(&:abs).sum

__END__
R4, R3, R5, L3, L5, R2, L2, R5, L2, R5, R5, R5, R1, R3, L2, L2, L1, R5, L3, R1, L2, R1, L3, L5, L1, R3, L4, R2, R4, L3, L1, R4, L4, R3, L5, L3, R188, R4, L1, R48, L5, R4, R71, R3, L2, R188, L3, R2, L3, R3, L5, L1, R1, L2, L4, L2, R5, L3, R3, R3, R4, L3, L4, R5, L4, L4, R3, R4, L4, R1, L3, L1, L1, R4, R1, L4, R1, L1, L3, R2, L2, R2, L1, R5, R3, R4, L5, R2, R5, L5, R1, R2, L1, L3, R3, R1, R3, L4, R4, L4, L1, R1, L2, L2, L4, R1, L3, R4, L2, R3, L1, L5, R4, R5, R2, R5, R1, R5, R1, R3, L3, L2, L2, L5, R2, L2, R5, R5, L2, R3, L5, R5, L2, R4, R2, L1, R3, L5, R3, R2, R5, L1, R3, L2, R2, R1
