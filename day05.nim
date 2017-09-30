import md5
import strutils


const DOOR_ID = "wtnhxymk"

var
  firstPassword = ""
  secondPassword: array['0'..'7', char]
  availablePositions = {'0'..'7'}
  i = 0

proc formatHex(n: uint8): char =
  toHex(n)[^1].toLowerAscii

while card(availablePositions) > 0:
  let
    s = DOOR_ID & intToStr(i)
    hash = s.toMD5

  if hash[0] == 0 and hash[1] == 0 and hash[2] < 16:
    let
      fifth = formatHex(hash[2] mod 16)
      sixth = formatHex(hash[3] shr 4)
    if len(firstPassword) < 8:
      firstPassword.add(fifth)
    if fifth in availablePositions:
      secondPassword[fifth] = sixth
      availablePositions.excl(fifth)
  i += 1

echo "The password for the first door is:  ", firstPassword
echo "The password for the second door is: ", join(secondPassword)
