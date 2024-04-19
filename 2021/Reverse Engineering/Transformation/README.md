# Transformation

**Tags:** *[PicoCTF2021](../../) [Reverse Engineering](../)*\
**Author:** MADSTACKS\
**Points:** 20

---

## Description

I wonder what this really is... [enc](enc)
```python
''.join([chr((ord(flag[i]) << 8) + ord(flag[i + 1])) for i in range(0, len(flag), 2)])
```

<details>
<summary>Hints</summary>
<br>
&nbsp; &nbsp; &nbsp; 1. You may find some decoders online  
<br>
</details>

---

## Solution

The challenge descriptions shows some python code. The code uses a variable: ***flag***, executes some operations on every index of it, and adds the results to an empty string. The functions ***ord()*** and ***chr()*** are used in these operations, which indicates that the indices of ***flag*** contain characters. This means that ***flag*** is a string.
The code does the following operations on ***flag***:
```python
result = ''
for i in range(0, len(flag), 2):
    number = ord(flag[i]) << 8 + ord(flag[i + 1])
    char = chr(number)
    result += char
```
For every two characters in ***flag***, the unicode number representations are found. The first of the two characters is bitshifted 8 bits to the left. After this the calculated numbers are added which is then encoded as a new unicode character. This unicode character is then added to the result string.
The bitshifting of exactly 8 bits indicates the the characters in ***flag*** are probably [ASCII](https://en.wikipedia.org/wiki/ASCII) characters. 


The provided file contains the following string: "灩捯䍔䙻ㄶ形楴獟楮獴㌴摟潦弸弰摤捤㤷慽". Feeding the string in the file to the provided code returns: <span style='color: red;'>ValueError: chr() arg not in range(0x110000)</span>. 
Taking the ***ord()*** on the first character '灩', results in 28777. This is not an ASCII character as the maximum value for those is 255. Bitshifting the characters results in numbers that are too big for unicode encoding. This means that ***flag*** is then probably encoded by the code into the given characters. This can be check by trying to encode the first two characters of the flag which are "pi". This results in the character: '灩'. This is the same character as the first one found in the given string. The text has to be decoded to find the flag.

The code to decode the provided string can be found in [decode.py](decode.py).

---

<details>
<summary><b>Flag</b></summary>
<br>
&nbsp; &nbsp; &nbsp; <b>picoCTF{16_bits_inst34d_of_8_0ddcd97a}</b>
<br>
</details>

---
