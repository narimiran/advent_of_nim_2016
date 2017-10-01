import complex
from strutils import splitLines

const
  instructions = readFile("./inputs/02 - Bathroom Security.txt").splitLines

  KEYPAD_1 = @[
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9']
  ]
  CENTER_1 = (1.0, 1.0) # position of a center
  START_1 = (0.0, 0.0)  # position of '5' relative to the center

  KEYPAD_2 = @[
    ['0', '0', '1', '0', '0'],
    ['0', '2', '3', '4', '0'],
    ['5', '6', '7', '8', '9'],
    ['0', 'A', 'B', 'C', '0'],
    ['0', '0', 'D', '0', '0']
  ]
  CENTER_2 = (2.0, 2.0) # position of a center
  START_2 = (-2.0, 0.0) # position of '5' relative to the center


proc isInside(pos: Complex, kpad: seq): bool =
  if len(kpad) == 3:
    abs(pos.re) <= 1 and abs(pos.im) <= 1
  else:
    abs(pos.re) + abs(pos.im) <= 2

proc findDirection(dir: char): Complex =
  case dir
    of 'R': (1.0, 0.0)
    of 'L': (-1.0, 0.0)
    of 'U': (0.0, -1.0)
    of 'D': (0.0, 1.0)
    else: (0.0, 0.0)

proc getKey(pos: Complex, kpad: seq): char =
  kpad[int(pos.im)][int(pos.re)]


proc solve(instructions: seq[string], kpad: seq, start, center: Complex) =
  var position = start

  proc findKey(line: string): Complex =
    for direction in line:
      let movement = findDirection(direction)
      if (position + movement).isInside(kpad): position += movement
    return position

  for line in instructions:
    stdout.write(getKey(center + findKey(line), kpad))
  echo "\n"


echo "The bathroom code is:"
solve(instructions, KEYPAD_1, START_1, CENTER_1)
echo "And for the other keypad:"
solve(instructions, KEYPAD_2, START_2, CENTER_2)
