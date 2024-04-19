# crackme-py

**Tags:** *[PicoCTF2021](../../) [Reverse Engineering](../)*\
**Author:** SYREAL\
**Points:** 30

---

## Description

[crackme.py](crackme.py)

<details>
<summary>Hints</summary>
<br>
&nbsp; &nbsp; &nbsp; (None) 
<br>
</details>

---

## Solution

The challenge gives a file containing a python script. This script contains two functions:

- ***decode_secret(secret)***
  : Given a string (secret), it tries to decode it and prints the result to the console.
- ***choose_greatest()***
  : Asks the user for two numbers and prints the largest number of the two.

The script automatically calls ***choose_greatest()***, which does nothing special for retrieving the flag. The script also contains a comment which tells that the secret is in this file and that is is encrypted. This secret is ***bezos_cc_secret*** and is probably the encrypted flag.

The flag can be found, by calling the ***decode_secret()*** functions on ***bezos_cc_secret***. The code to find the flag is found in [crack.py](crack.py).

---

<details>
<summary><b>Flag</b></summary>
<br>
&nbsp; &nbsp; &nbsp; <b>picoCTF{1|\/|_4_p34|\|ut_8c551048}</b>
<br>
</details>

---
