from algorithm import sorted
import strutils
import sets

const input = readFile("./inputs/06 - Signals and Noise.txt").splitLines
var
  mostCommon = ""
  leastCommon = ""
  columns = ["", "", "", "", "", "", "", ""]


proc letterCount(column: string): seq[tuple[count: int, letter: char]] =
  result = @[]
  for ch in column.toSet:
    result.add((column.count(ch), ch))
  return result.sorted(cmp)


for line in input:
  for i, c in line:
    columns[i].add(c)

for col in columns:
  let lc = col.letterCount
  mostCommon.add(lc[^1][1])
  leastCommon.add(lc[0][1])

echo "The most common characters are: \t", mostCommon
echo "The least common characters are: \t", leastCommon
