***Table of Contents***

1. [[#Definition vs Declaration|Definition vs Declaration]]
2. [[#Libraries and functions|Libraries and functions]]
3. [[#Header files|Header files]]
4. [[#Compiling code|Compiling code]]
	1. [[#Compiling code#Using a `makefile`|Using a `makefile`]]
5. [[#Misc.|Misc.]]

# Definition vs Declaration
**The definition of a function contains** : 
- the function name 
- the name and the type of each of its arguments enclosed within parenthesis 
- the type of the return value — the body of the function (local variable declarations ; list of instruction to be executed)

**A function declaration** contains only the prototype of the function which consists of the name, the type of each parameters of the function enclosed in parenthesis 1 and the type of the return value of the function.
```c
void funky(int);
```
# Libraries and functions
- `stdio.h`
	- **printf()**
	  ![[Pasted image 20251001230100.png]]
	  ![[Pasted image 20251001230712.png]]
	- **getchar()** which reads a character from the standard input and return its value.

# Header files
We can use header files to declare functions that we can use in other scripts.
The header file `lib.h` only contains the [[#Definition vs Declaration|declaration]] 
```c
void funky(int);
```
and a C file with the same name `lib.c` contains the [[#Definition vs Declaration|definition]]
```c
void funky(int num){
	//...
}
```
now you can include your header file in your main script
```c
#include "funky.h"
```
# Compiling code
You can compile your code with either `gcc` or `cc` like the following:
```c
gcc [all the required C files] -c [output name]
```

## Using a `makefile`
Firstly make a file called `makefile`, then run `make` in the same directory of the file to run the commands found in the make file.


---
# Misc.
- ***What is character encoding?*** A character encoding associate a set of printable characters (digits, letters, graphical sym- bols, . . .) with a set of numerical values. One of the most used encoding is the ASCII 