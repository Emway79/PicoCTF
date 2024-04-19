"""
Decodes the string 'enc' into the flag.

Every character is turned into its unicode number representation.
The first 8 bits is the first ASCII character and the last 8 bits is the second ASCII character. The characters are then appended onto the flag.
Ends wth printing the flag.
"""

enc = "灩捯䍔䙻ㄶ形楴獟楮獴㌴摟潦弸弰摤捤㤷慽"
result = ''

for char in enc:
    number = ord(char)
    char_1 = chr(number >> 8)
    char_2 = chr(number & 0xFF)
    result += char_1 + char_2

print(result)