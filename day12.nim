import strutils, tables

const instructions = readFile("./inputs/12 - Leonardo's Monorail.txt").splitLines

proc execute(c: int): int =
  var
    register = {"a": 0, "b": 0, "c": c, "d": 0}.toTable()
    i = 0

  proc interpret(val: string): int =
    if val.isDigit: return val.parseInt
    else: return register[val]

  while i < instructions.len:
    let
      commands = instructions[i].splitWhitespace()
      instr = commands[0]
      x = commands[1]
      y = if commands.len == 3: commands[2] else: nil

    case instr
    of "cpy": register[y] = x.interpret
    of "inc": inc register[x]
    of "dec": dec register[x]
    of "jnz":
      if x.interpret != 0:
        i += y.parseInt
        continue
    inc i

  return register["a"]


echo execute(c=0)
echo execute(c=1)
