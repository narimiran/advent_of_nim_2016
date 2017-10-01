from algorithm import sorted
from strutils import splitLines, splitWhitespace, parseInt
from sequtils import map


const input = readFile("./inputs/03 - Squares With Three Sides.txt").splitLines

var
  firstCol: array[input.len, int]
  secondCol: array[input.len, int]
  thirdCol: array[input.len, int]
  horizontalTriangles: int
  verticalTriangles: int

proc isTriangle(sides: seq[int]): bool =
  var sl = sides.sorted(cmp)
  return sl[0] + sl[1] > sl[2]


for i, candidate in input:
  let line = candidate.splitWhitespace.map(parseInt)
  if line.isTriangle: horizontalTriangles += 1

  firstCol[i] = line[0]
  secondCol[i] = line[1]
  thirdCol[i] = line[2]

for column in [firstCol, secondCol, thirdCol]:
  for i in countup(0, high(column)-2, 3):
    if @[column[i], column[i+1], column[i+2]].isTriangle:
      verticalTriangles += 1


echo "There are ", horizontalTriangles, " horizontal triangles."
echo "There are ", verticalTriangles, " vertical triangles."
