import algorithm
import strutils
import tables

const input = readFile("./inputs/10 - Balance Bots.txt").splitLines

var
  stack: seq[int] = @[]
  bots = initTable[int, seq[int]]()
  outputs = initTable[int, int]()
  connections = initTable[int, tuple[lowCon, highCon: string]]()


proc addBot(name, value: int) =
  if not bots.hasKey(name):
    bots[name] = @[value]
  else:
    bots[name].add(value)
    stack.add(name)


proc sendValue(connection: string, value: int) =
  let
    words = connection.split
    outType = words[0]
    outName = words[1].parseInt
  if outType == "bot":
    addBot(outName, value)
  else:
    outputs[outName] = value


for line in input:
  let words = line.split
  if line.startsWith("value"):
    let
      value = words[1].parseInt
      name = words[^1].parseInt
    addBot(name, value)
  else:
    let
      name = words[1].parseInt
      lower = words[5..6].join(" ")
      higher = words[^2..^1].join(" ")
    connections[name] = (lower, higher)


while len(stack) > 0:
  let
    name = stack.pop()
    sendTo = bots[name].sorted(cmp)
    lower = sendTo[0]
    higher = sendTo[1]
  if lower == 17 and higher == 61:
    echo name
  sendValue(connections[name].lowCon, lower)
  sendValue(connections[name].highCon, higher)


var result = 1
for chip in [0, 1, 2]:
  result *= outputs[chip]
echo result
