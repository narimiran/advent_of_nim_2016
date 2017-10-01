from algorithm import sorted
import strutils
import sets


const input = readFile("./inputs/04 - Security Through Obscurity.txt").splitLines

proc getLetterCount(name: string): seq[tuple[count: int, letter: char]] =
  result = @[]
  for ch in name.toSet:
    result.add((-name.count(ch), ch))
  return result.sorted(cmp)

proc findTopXLetters(letterCount: seq[tuple[count: int, letter: char]], x = 5): string =
  result = ""
  for entry in letterCount[0..<x]:
    result.add(entry.letter)

proc decryptName(name: string, sector: int): string =
  result = ""
  for ch in name:
    let shiftedOrd = (ord(ch) - 97 + sector) mod 26 + 97
    result.add(chr(shiftedOrd))


var total: int

for line in input:
  let name = line[0..^12].replace("-", "")
  let sector = line[^10..^8].parseInt
  let chSum = line[^6..^2]
  let letterCount = getLetterCount(name)
  let top5 = findTopXLetters(letterCount)
  let decryptedName = decryptName(name, sector)

  if top5 == chSum:
    total += sector
  
  if decryptedName.startsWith("northpole"):
    echo "There's something in '$1', at sector $2." % [decryptedName, $sector]

echo "The sum of all real rooms is: $1." % $total
