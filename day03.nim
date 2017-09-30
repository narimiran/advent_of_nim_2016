from algorithm import sorted
from strutils import splitWhitespace, parseInt
from sequtils import map


let f = open("./inputs/03 - Squares With Three Sides.txt")

var
  firstCol: seq[int] = @[]
  secondCol: seq[int] = @[]
  thirdCol: seq[int] = @[]
  horizontalTriangles: int
  verticalTriangles: int

proc isTriangle(sides: seq[int]): bool =
  var sl = sides.sorted(cmp)
  return sl[0] + sl[1] > sl[2]


for candidate in f.lines:
  let line = candidate.splitWhitespace.map(parseInt)
  if line.isTriangle: horizontalTriangles += 1

  firstCol.add(line[0])
  secondCol.add(line[1])
  thirdCol.add(line[2])

for column in [firstCol, secondCol, thirdCol]:
  for i in countup(0, high(column)-2, 3):
    if @[column[i], column[i+1], column[i+2]].isTriangle:
      verticalTriangles += 1


echo "There are ", horizontalTriangles, " horizontal triangles."
echo "There are ", verticalTriangles, " vertical triangles."
