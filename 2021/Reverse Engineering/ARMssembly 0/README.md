# ARMssembly 0

**Tags:** *[PicoCTF2021](../../) [Reverse Engineering](../)*\
**Author:** Dylan McGuire\
**Points:** 40

---

## Description

What integer does this program print with arguments <span style='color: #F4A4B5;'>4004594377</span> and <span style='color: #F4A4B5;'>4110761777</span>? File: [chall.S](chall.S) Flag format: picoCTF{XXXXXXXX} -> (hex, lowercase, no 0x, and 32 bits. ex. 5614267 would be picoCTF{0055aabb})

<details>
<summary>Hints</summary>
<br>
&nbsp; &nbsp; &nbsp; 1. Simple compare
<br>
</details>

---

## Solution
This challenge gives an assembly file to reverse engineer. The header of the file shows that the file contains [Armv8-A assembler language](). The first thing to take a look at, are the labels in the assembler code. The file contains five lables: 'func1', 'L1', 'L2', 'LC0' and 'main'. Two of these are subroutines: 'func1' and 'main', where main is the entrypoint of the program.

The program uses three different types of registers ([Armv8-A cheatsheet]()):

SP 
: The current stack pointer

X(0 - 30)
: 64-bit general purpose registers

W(0 - 30)
: 32-bit general purpose registers (Same registers as the X registers, but only the bottom 32 bits)

With the help of the [Armv8-A documentation]() the code can be reverse engineered into a high level description of what the code does. Lets start with the main function:
chall.S#L30


---

<details>
<summary><b>Flag</b></summary>
<br>
&nbsp; &nbsp; &nbsp; <b>f</b>
<br>
</details>

---
