import nre
import strutils

let 
  f = open("./inputs/09 - Explosives in Cyberspace.txt").readLine
  pattern = re"\(\d+x\d+\)"


proc unzip(s: string, secondPart = false): int =
  let parens = s.find(pattern)
  if parens.isNone:
    return len(s)

  let
    nrs = split($parens.get, 'x')
    length = nrs[0][1..^1].parseInt
    times = nrs[1][0..^2].parseInt
    beginning = parens.get().captureBounds[-1].get().a
    start = beginning + len($parens.get())

  var count = length
  if secondPart:
    count = unzip(s[start..<start+length], true)

  return len(s[0..<beginning]) + times*count + unzip(s[start+length..^1], secondPart)


echo "Decompressed size: ", unzip(f)
echo "Fully decompressed size: ", unzip(f, true)
