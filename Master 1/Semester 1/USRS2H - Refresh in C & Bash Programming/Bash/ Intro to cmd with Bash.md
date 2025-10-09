***Table of Contents***

1. [[#Terminal shortcuts|Terminal shortcuts]]
2. [[#The 3 types of files|The 3 types of files]]
3. [[#Commands|Commands]]
	1. [[#Commands#Working with directories|Working with directories]]
	2. [[#Commands#Working with files|Working with files]]
	3. [[#Commands#Text related commands|Text related commands]]
4. [[#`more` vs `less`|`more` vs `less`]]
5. [[#Getting help with ma `man`|Getting help with ma `man`]]
6. [[#File access management|File access management]]
	1. [[#File access management#`chmod`|`chmod`]]
		1. [[#`chmod`#First method|First method]]
		2. [[#`chmod`#Second method|Second method]]
7. [[#Regex|Regex]]
	1. [[#Regex#Single `'` vs Double `"` quotes|Single `'` vs Double `"` quotes]]
8. [[#Terminal standard input and output|Terminal standard input and output]]
	1. [[#Terminal standard input and output#Redirecting inpt/output|Redirecting inpt/output]]
		1. [[#Redirecting inpt/output#Pipe `|` operator|Pipe `|` operator]]
9. [[#Jobs|Jobs]]
10. [[#Environment variables|Environment variables]]
11. [[#Creating a shell script|Creating a shell script]]
	1. [[#Creating a shell script#if statements|if statements]]
	2. [[#Creating a shell script#loops|loops]]
	3. [[#Creating a shell script#Passing parameters to your script|Passing parameters to your script]]
		1. [[#Passing parameters to your script#functions|functions]]
	4. [[#Creating a shell script#Running your script without specifying the path|Running your script without specifying the path]]

# Terminal shortcuts
![[Pasted image 20250930122146.png]]

# The 3 types of files
- `ordinary files`: they contains data useful to run the computer (system data, application data, . . . ) and to the user (user documents, user pictures, . . . ) 
- `directory files or folders`: a directory (or a folder) is a file which contains references to other files
- `special files:` symbolic links, device files, communication pipe, . . .

> [!warning] Naming Constraints
> All characters are allowed when naming, except `/`.
> But its better to avoid special characters that have a meaning in the shell:
> `\ > < | $ ? & [ ] * ! " ‘ ( ) @ ˜ (and space)`

# Commands
## Working with directories
![[Pasted image 20250930113914.png]]
## Working with files
![[Pasted image 20250930113951.png]]
> [!info]
> `touch` creates a file

## Text related commands
check [[#Pipe ` ` operator|pipe operator]]
![[Pasted image 20250930132848.png]]

# `more` vs `less`
Both of these commands make it easier to navigate large output. But `more` allows only for forward navigation and has no search, unlike `less`.
# Getting help with ma `man`
Theres different ways of finding the documentation of a command:
- `man [command]` best
- `[command] --help` good enough
- `info [command]` worst
# File access management
First of all, to view the permissions on a file, include the `-l` option in `ls`
Example:
```sh
ls -l /usr/bin
# output:
lrwxrwxrwx 1 root root           4 Aug  9  2024  zstdmt -> zstd
```

We have 3 kinds of users that can access a file:
- Owner `u`
- Group user `g`
- Other `o`
- Everyone/All `a`

Each can have the following permissions
- `r` read
- `w` write
- `x` execute
## `chmod` 
Use this command to change the permissions of the user in 2 ways
### First method
```sh
chmod [user_type][+(add) or -(remove)][permissions] [file]
# example
chmod ug+rx ./myfile.sh
```

### Second method
We can use numbers to set the perms:
- `7` is `rwx`
- `6` is `rw`
- `4` is `r`
- `0` is remove all perms

So we can do:
```
chmod 777 [file]
```
The numbers order is:
- first is for the user
- second is for the group
- third is for others

# Regex
You can use regex when searching for a file
![[Pasted image 20250930122402.png]]

> [!info]
> You can use `\` to ignore the regex and treat it as a normal character

## Single `'` vs Double `"` quotes
Any special characters are ignored inside single quotes, but not in double quotes

# Terminal standard input and output
pretty much for any command you have the following:
- std input
- std output
- std error (output)
![[Pasted image 20250930132352.png]]

## Redirecting inpt/output
![[Pasted image 20250930132532.png]]

### Pipe `|` operator
the pipe `|` lets you "pipe" the output of a command as an input for another command instead of saving or reading from a file

# Jobs
Especially when you open an application/job, it blocks you from writing any more commands and instead the job uses the terminal to write logs and errors, however we can manipulate how the job behaves, firs we need the job number, which we can do by putting `&` at the end of the job call

```sh
emcas &
# emacs is an app i.e. job
# output:
[1] 23456
```
The number between the brackets is the job number.

The following are the commands we can use to manipulate the job
![[Pasted image 20250930140427.png]]

Or with the following shortcuts
![[Pasted image 20250930140450.png]]

# Environment variables
A list of key value pairs that you can access in your bash session. 
You can list these variables using `env` and display a specific value with `echo $var_name` 

To add a variable to the list (like *i=1*) you `export` the variable
```sh
export i
```
this will allow you to use this variable between sessions.
You can start a new session by executing `bash` (for us there is no use yet, so if you restart the terminal, the exported variables will be gone)

> [!info]
> to permanently add variables to the env vars, you have to export them inside the `~/.bashrc` file


# Creating a shell script
Simply create a file with any command and save it, e.g.
```sh
ls -l /usr/bin | head -n 10
```
and run it with `bash`
```sh
bash ./file
```
if you wish to ommit the `bash`, then you can point the file to the bash directory at the top of the file
```sh
#!/bin/bash
ls -l /usr/bin | tail -n +10
```
make it executable (check [[#`chmod`]])and run it.

## if statements
```sh
number=10

if [ $number -gt 5 ]; then
    echo "Number is greater than 5"
elif [ $number -eq 5 ]; then
    echo "Number is equal to 5"
else
    echo "Number is less than 5"
fi
```

Common operators:
- `-eq` (equals), `-ne` (not equal)
- `-lt` (less than), `-le` (less or equal)
- `-gt` (greater than), `-ge` (greater or equal)

## loops
**for loop**
```sh
for i in 1 2 3 4 5; do
    echo "Number: $i"
done
```
**for loop with a range**
```sh
for i in {1..5}; do
    echo "Number: $i"
done
```
**while loop**
```sh
count=1
while [ $count -le 5 ]; do
    echo "Count: $count"
    count=$((count+1))
done
```

## Passing parameters to your script
Inside a script we have these global variables:
- `$0` = script name
- `$1`, `$2`, … = arguments
- `$#` = number of arguments
- `$@` = all arguments as a list

*Example of calling a script with arguments*
```sh
bash myscript.sh apple banana cherry
```

but take note that these are context dependent, so inside a function they would act as function params and not as script params

### functions 
```sh
greet() {
    echo "Hello, $1!"
}

greet "World"
greet "Potato"
```

## Running your script without specifying the path
simply add the folder its contained it to the PATH variable (check [[#Environment variables]])
```sh
export PATH="$PATH:/your/new/path"
```
