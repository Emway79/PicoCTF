# keygenme-py

**Tags:** *[PicoCTF2021](../../) [Reverse Engineering](../)*\
**Author:** SYREAL\
**Points:** 30

---

## Description

[keygenme-trial.py](keygenme-trail.py)

<details>
<summary>Hints</summary>
<br>
&nbsp; &nbsp; &nbsp; (None) 
<br>
</details>

---

## Solution

The challenge gives a file containing a python script. This python script is the "Arcane calculator". Upon running the script, it prints a menu which gives 4 options:

<ol type="a">
  <li>Estimate Astral Projection Mana Burn</li>
  <li>[LOCKED] Estimate Astral Slingshot Approach Vector</li>
  <li>Enter License Key</li>
  <li>Exit Arcane Calculator</li>
</ol>

Option a, b and d are not that usefull as they do not help with getting the flag.
Option c checks if we have the license key and opens up option b if it is correct.
The input is checked against the following string: "picoCTF{1n_7h3_|&lt3y_of_xxxxxxxx}" where the x's are unknown to the user. This string has the format of the flag, which means that finding what the x's are supposed to be, results in the flag. Every character of the unknown part is checked against an index of a hash of ***username_trail***. This variable has the value of: "MORTON". This means that the unknown characters can be found by hashing ***username_trail*** and putting the specific characters of the hash in the order the scripts checks them. The code to find the unknown part of the flag can be found in [keyfinder.py](keyfinder.py).


---

<details>
<summary><b>Flag</b></summary>
<br>
&nbsp; &nbsp; &nbsp; <b>picoCTF{1n_7h3_|&lt3y_of_75fc1081}</b>
<br>
</details>

---
