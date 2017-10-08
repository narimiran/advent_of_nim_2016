import complex
import strutils
import tables

const
  instructions = readFile("./inputs/01 - No Time for a Taxicab.txt").strip.split(", ")
  rotation = {
    'L': (re: 0.0, im: 1.0),
    'R': (re: 0.0, im: -1.0)
  }.toTable

proc manhattan(pos: Complex): float =
  abs(pos.re) + abs(pos.im)

var
  direction: Complex = (0.0, 1.0)
  position: Complex = (0.0, 0.0)
  visited: seq[Complex] = @[]
  foundFirst: bool

for instr in instructions:
  let rot = instr[0]
  let length = parseInt instr[1..^1]
  direction *= rotation[rot]

  for _ in 1..length:
    position += direction
    if not foundFirst and position in visited:
      echo "Here I am again, at: ", position
      echo "That's ", int manhattan position, " blocks from the start"
      foundFirst = true
    else:
      visited.add(position)

echo "Finally came to the end, at ", position
echo "That's ", int manhattan position, " blocks from the start"
