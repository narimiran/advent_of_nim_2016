import strutils
import deques
import osproc
import os

let input = readFile("./inputs/08 - Two-Factor Authentication.txt").splitLines

const
  width = 50
  height = 6
  on = '#'

var
  lcd: seq[Deque[char]] = @[]
  rows = initDeque[char]()
  lit = 0

for _ in 1..width:
  rows.addLast(' ')
for _ in 1..height:
  lcd.add(rows)


proc createRect(lcd: var seq[Deque[char]], size: string) =
  let
    dimensions = size.split('x')
    w = parseint(dimensions[0])
    h = parseInt(dimensions[1])
  for y in 0..<h:
    for x in 0..<w:
      lcd[y][x] = on


proc rotate(line: var Deque[char], amount: int) =
  for _ in 1..amount:
    line.addFirst(line.popLast)


proc rotateCol(lcd: var seq[Deque[char]], column, amount: int) =
  var col = initDeque[char]()
  for r in 0..<len(lcd):
    col.addLast(lcd[r][column])
  col.rotate(amount)
  for r in 0..<len(lcd):
    lcd[r][column] = col[r]


proc getPosition(pos: string): int =
  return parseInt pos.split('=')[1]


proc print(lcd: seq[Deque[char]]) =
  discard execCmd "clear"
  for line in lcd:
    var row = ""
    for c in line:
      row.add(c)
    echo row
  sleep(100)


for line in input:
  let words = line.split
  case words[0]
  of "rect": lcd.createRect(words[1])
  of "rotate":
    let
      amount = parseInt(words[^1])
      position = getPosition(words[2])
    case words[1]
    of "row": lcd[position].rotate(amount)
    of "column": lcd.rotateCol(position, amount)
  lcd.print

for line in lcd:
  for c in line:
    if c == '#':
      lit += 1
echo lit
