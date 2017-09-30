import strutils
import deques
import osproc
import os

let f = open("./inputs/08 - Two-Factor Authentication.txt")

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


proc createRect(lcd: var seq[Deque[char]], size: string): seq[Deque[char]] =
  let
    dimensions = size.split('x')
    w = parseint(dimensions[0])
    h = parseInt(dimensions[1])
  for y in 0..<h:
    for x in 0..<w:
      lcd[y][x] = on
  return lcd


proc rotate(line: var Deque[char], amount: int): Deque[char] =
  for _ in 1..amount:
    line.addFirst(line.popLast)
  return line


proc rotateRow(lcd: var seq[Deque[char]], row, amount: int): seq[Deque[char]] =
  lcd[row] = rotate(lcd[row], amount)
  return lcd


proc rotateCol(lcd: var seq[Deque[char]], column, amount: int): seq[Deque[char]] =
  var col = initDeque[char]()
  for r in 0..<len(lcd):
    col.addLast(lcd[r][column])
  col = rotate(col, amount)
  for r in 0..<len(lcd):
    lcd[r][column] = col[r]
  return lcd


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


for line in f.lines:
  let words = line.split
  if words[0] == "rect":
    lcd = lcd.createRect(words[1])
  elif words[1] == "row":
    lcd = lcd.rotateRow(getPosition(words[2]), parseInt(words[^1]))
  else:
    lcd = lcd.rotateCol(getPosition(words[2]), parseInt(words[^1]))
  lcd.print

for line in lcd:
  for c in line:
    if c == '#':
      lit += 1
echo lit
