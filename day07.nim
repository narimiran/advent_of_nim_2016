import nre
import strutils

let
  input = readFile("./inputs/07 - Internet Protocol Version 7.txt").splitLines
  pattern = re"\[|\]"

var
  tls: int
  ssl: int

proc isABBA(line: string): bool =
  for i in 0..line.len-4:
    let (a, b, c, d) = (line[i], line[i+1], line[i+2], line[i+3])
    if a == d and b == c and a != b:
      return true

proc isSSL(sup, hyp: string): int =
  for i in 0..sup.len-3:
    let (a, b, c) = (sup[i], sup[i+1], sup[i+2])
    if a == c and a != b and b&a&b in hyp:
      return 1

for line in input:
  let nets = line.split(pattern)
  var
    hyp = ""
    sup = ""
  for i, word in nets:
    if i mod 2 == 0:
      sup.add(word & " ")
    else:
      hyp.add(word & " ")
  if isABBA(sup) and not isABBA(hyp):
    tls += 1
  ssl += isSSL(sup, hyp)


echo "Number of TLS supporting addresses: ", tls
echo "Number of SSL supporting addresses: ", ssl
