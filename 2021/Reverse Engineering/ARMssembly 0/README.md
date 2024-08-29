# ARMssembly 0

**Tags:** *[PicoCTF2021](../../), [Reverse Engineering](../)*\
**Author:** Dylan McGuire\
**Difficulty:** Medium

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
This challenge gives an assembly file to reverse engineer. The header of the file shows that the file contains [Armv8-A assembler language](https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/Learn%20the%20Architecture/Armv8-A%20Instruction%20Set%20Architecture.pdf?revision=ebf53406-04fd-4c67-a485-1b329febfb3e) also known as aarch64. There are two different ways of solving this challenge: compile the Armv8-a assembler and run the binary with the two given arguments, or reverse engineer the code to understand its behaviour and then derive the result. 

### Option 1: Reverse engineering
With the help of the [Armv8-A documentation](https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/Learn%20the%20Architecture/Armv8-A%20Instruction%20Set%20Architecture.pdf?revision=ebf53406-04fd-4c67-a485-1b329febfb3e) the code can be reverse engineered to create a higher level description of what the code does. This has been done in the [source code](chall.S) with two columns of comments. The first column translates the instructions into English. The second column interprets the function of each instruction with knowledge of previous instructions. The functions in the source code have also been given a high-level description which includes the arguments, a simplification in C-style code and the return value.

The first things to look at, are the labels in the assembler code. The file contains five labels: 'func1', 'L1', 'L2', 'LC0' and 'main'. Two of these are subroutines: 'func1' and 'main', where main is the entry point of the program.

The program uses three different types of registers ([Armv8-A cheatsheet](https://courses.cs.washington.edu/courses/cse469/19wi/arm64.pdf)):

<dl>
  <dt>SP</dt>
  <dd>The current stack pointer</dd>
  
  <dt>X(0 - 30)</dt>
  <dd>64-bit general-purpose registers</dd>
  
  <dt>W(0 - 30)</dt>
  <dd>32-bit general purpose registers (Same registers as the X registers, but only the bottom 32 bits)</dd>
</dl>

##### Main
The first instructions of the main function seem arbitrary, but they handle the arguments from char** argv which includes the two given numbers for running the program. The two arguments are given to the program in string form, so the program converts both numbers with the [atoi](https://en.cppreference.com/w/c/string/byte/atoi) function from the C standard library. The other function: func1(arg1, arg2), is then called with both numbers in integer form as its arguments. The return value of that function is then put into a format string which is loaded from .LC0 and printed to the standard output with the [printf](https://en.cppreference.com/w/c/io/fprintf) function from the C standard library.

##### Func1
Main calls func1 with arg1 and arg2 in the form of integers. The integers are compared and the greatest of both is returned. This would be the number: 4110761777.


### Option 2: Compile and run
The other option is to compile the Armv8-A assembler and run it with both arguments to find the output. My machine uses x86-64 also known as amd64 architecture, which is not able to run programs compiled for Armv8-A architecture and also does not come with an Armv8-A compiler for that reason.

First, we need to be able to compile for Armv8-A:

```bash
sudo apt install binutils-aarch64-linux-gnu
sudo apt install gcc-aarch64-linux-gnu
```

Now we can compile [chall.S](chall.S) into an executable binary:

```bash
aarch64-linux-gnu-gcc chall.S -o chall -static
```

The static flag is chosen because the dynamic libraries can not be found on a non-Armv8-A machine.

The binary can not be run on the system without an Armv8-A emulator:

```bash
sudo apt install qemu-user
```

Now we can run the [chall](chall) with both arguments the usual way:

```bash
./chall 4004594377 4110761777
```

This prints the following on the standard output:
> Result: 4110761777

---
The program with the arguments will print 4110761777 on the standard output. Converting it to hexadecimal gives F5053F31. Put this number in the flag format and we have found the flag.

<details>
<summary><b>Flag</b></summary>
<br>
&nbsp; &nbsp; &nbsp; <b>picoCTF{XXXXXXXX}</b>
<br>
</details>

---
