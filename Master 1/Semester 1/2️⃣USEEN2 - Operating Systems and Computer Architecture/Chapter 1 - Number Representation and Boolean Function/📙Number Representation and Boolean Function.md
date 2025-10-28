> [!bug] HOLD YO HORSES
> I really recommend you do the exercises found in the documents folder

# Introduction
> [!hint]
> Not exactly important, skip to [[#Base systems]]
## Compilation Process
![[Pasted image 20251006095611.png|600]]
## Information Encoding
Information encoding = link between the external (natural) representation of information (character ’A’ or number 36) and its binary representation (sequences of bits: 0010 0100)

# Base systems
## Base notations
![[Pasted image 20251008141802.png|500]]

> [!info] Most and least significant bits
> The most significant bit `(MSB)` is to the left, and the least significant bit `(LSB)` is to the right *(This applies for any base)* ^sb
## Conversions:
### Converting any base to decimal
The rule is multiply each digit with the base number to the power of its position and add them all up
![[Pasted image 20251008141505.png|600]]
![[Pasted image 20251006103326.png|600]]

### Converting $Binary_2$ to $Decimal_{10}$
![[Pasted image 20251008191440.png]]

### Converting $Hexadecimal_{16}$ to $Decimal_{10}$ 
![[Pasted image 20251008191649.png]]

## Converting $Binary_2$ to a base of multiple of 8 (Hex, Octal...) and vice versa
- **Octal:** Split the binary number into `groups of 3 digits`
- **Hex:** Split the binary number into `groups of 4 digits`

To convert to binary, just replace each digit with its binary form. 
### Conversion algorithms:
#### Successive divisions (base 10 to B > 1)
```py
queue = []
while Number > 0:
	Quotient = Number / Base
	Remainder = Number % Base
	queue.enqueue(Remainder)
	Number = Quotient
# the resulting queue is our number in the new base
```

> [!help] How to calculate the remainder
> Consider 255 / 16 = 15.93
> Quotient x Base + Remainder = Number
> 15 x 16 = 240 (quotient by base is not enough)
> 240 + 15 = 255 (so we add back the remainder)

> [!example]
> ![[Pasted image 20251009195555.png|300]]

#### Searching for power of multiples of B
Conversion of a given number N to a base B > 1 on (k + 1) digits by searching for power multiples of B.

```py
find exponent such that base^exponent is the highest but less than the number

k = exponent
i = exponent
result = []

while Number >= 0 and i >= 0 do
	find alpha in [0, B-1] such that
		alpha * Base^i <= Number < (alpha+1)*Base^i
	result[i] = alpha
	Number = Number - alpha * Base^i
	i--
```

> [!example]
> ![[Pasted image 20251009201144.png|600]]
## Boundedness
Numbers are represented in fixed size words *(8, 16, 32 or 64 bits)*, so not all numbers can be represented.

So for **p symbols** in **base B** only natural numbers within interval \[0, $\large B^p$ − 1] can be represented.

### Expanding the bounds
For any **base B**, a natural number represented on **p symbols** can be extended on **n > p symbols** by **introducing 0 on symbols of ranks p to n − 1**.

*Example:* $0011_b → 00000011_b$

--- 
# Base Arithmetic
## Addition
### Base 2: Binary
*Addition rules:*
![[Pasted image 20251009202400.png|400]]
When there is a carry, carry is summed with the bit on the left. So, three digits needs to be added (instead of 2)

> [!example]
> - 1 + 1 + 1 = 3d =11b, 1 and carry = 1 
> - ![[Pasted image 20251009202529.png|300]]

> [!caution]
> In case of a carry that exceeds the size of the bits; we discard the whole sum, because it cannot be represented in the current bit size

#### Carry in & out
The computer always does a carry even if the addition is $0+0=0$ we still have a carry of 0. And so we always have a bit that goes ("overflows") the addition; which we call **carry out**. While the carries inside the added bits are called **carry in**. And based on these we decide if we have an overflow

**For signed integers:**

| Carry out | Carry in | Overflow? |
| :-------: | :------: | :-------: |
|     0     |    0     |    no     |
|     0     |    1     |    yes    |
|     1     |    0     |    yes    |
|     1     |    1     |    no     |
Which is: Overflow = out XOR in

**For [[#Two's complement|unsigned integers]]:**

| Carry out | Carry in | Overflow? |
| :-------: | :------: | :-------: |
|     0     |    0     |    no     |
|     0     |    1     |    yes    |
|     1     |    0     |    yes    |
|     1     |    1     |    yes    |
Which is: Overflow = carry out

> [!danger] ATTENTION!
> Always show your carry in and out when doing a calculation.
> I recommend you check exercise 12 in [[td 1 Solutions]]


### Base 16: Hex
Addition is done by summing digits of same rank.Carry propagation when the result is greater than 16
> [!example]
> ![[Pasted image 20251009203042.png]]
## Subtraction
### Base 2: Binary
*Rules:*
![[Pasted image 20251009210814.png|500]]

> [!question] Carrying
> I used the method in this video
> https://youtu.be/h_fY-zSiMtY?si=-L-VH_eDkOtknt67
> Where you keep taking 2 bits from the left 

> [!example]
> ![[Pasted image 20251009211039.png]]

> [!danger] In case we cant borrow from the left
> For example, you cant subtract 01 - 11
> ![[Pasted image 20251009211123.png]]

## Multiplication & Division
![[Pasted image 20251009211344.png]]

### Shifting
![[Pasted image 20251009211409.png]]


# Two's complement
We use two's complement to represent negative values. **The [[#^sb|MSB]] is reserved for representing the sign of the value.** (0 for positive, 1 for negative).

To convert to a negative number we simply do the following:
1. Complement all the values
2. Add 1

> [!question] Reversing
> *You can do the same steps in reverse to convert into positive or simply complement and add again or just convert to decimal as we will see later*

> [!example]
> ![[Pasted image 20251008192833.png]]

The range value of two's complement is: $\large [−2^{n−1}; \space 2^{n−1} − 1]$

## Converting 2's complement to decimal
Same process as in [[#Converting any base to decimal]], but use the [[#^sb|MSB]] to indicate the sign of the last digit. (so 0 positive and 1 is negative)

> [!example]
> ![[Pasted image 20251008193420.png|600]]

## Extending a signed number
Integer extension on n bits to n > p bits : 
1. bits of rank 0 to p − 1 remain unchanged 
2. bits of rank p to n − 1 take the same value as the sign bit (rank p − 1)

> [!example]
> $1001_b = 11111001_b$

# ASCII Encoding
In this encoding, a character is encoded on 1 byte, a corresponding table give the encoding. Only 7 of the 8 bits are used; the [[#^sb|MSB]] is always 0.
![[Pasted image 20251008194445.png]]

> [!example] Example of word coding
> ![[Pasted image 20251008194724.png]]

> [!caution]
> the 0x00 (\0) marks the end of the string
## Extension of ASCII: `iso-latin1`
![[Pasted image 20251008194539.png]]

# Boolean Logic
> [!info] Defintion
Let $\mathbb{B}$ the alphabet $\mathbb{B} = \{True, False\} = \{T,F\} = \{1,0\}$.
> - Order on the elements of $\mathbb{B} : 0 < 1$
> - Truth table = enumeration of values taken by a [[#Boolean functions|boolean function]] f depending on its parameters 

## Boolean functions
- A **boolean function** is a function on $\mathbb{B}^n \rightarrow \mathbb{B}$
- **Boolean variable** = a variable that could be true or false

> [!example]
> ![[Pasted image 20251013111947.png]]

## Operations
- Complement or negation: **NOT (unary function)**
  If a = 0 then $\bar{a}$ = 1 and if a = 1 then $\bar{a}$ = 0 
- Addition/Disjunction: **OR (binary function)** 
  $a + b = max(a, b)$ 
- Multiplication/Conjunction: **AND (binary function)** 
  $a.b = min(a, b)$

## Properties
In boolean algebra, the addition and multiplications are:
1. Associative 
2. Commutative
3. Distributive with respect to each other
   ![[Pasted image 20251013113522.png]]

- **Morgan's Law:** $$\overline{x+y} = \bar x.\bar y$$$$\overline{x.y}=\bar x + \bar y$$
- **Simplification rules:**
	- Involution law: $\bar{\bar{x}} = x$
	- Absorbing element: $x.0 = 0 \space and \space x + 1 = 1$
	- Idempotence: $x.x = x \space and \space x + x = x$

## Algebraic Expression of a bool function (Normal Forms)
Any Boolean function f can be expressed only using constant 0 and 1, name of Boolean parameters of f and operators +, . and - of Boolean Algebra.

Algebraic expression of a Boolean function f can be constructed from its truth table as:
- [[#Disjunctive Normal Form]]
- [[#Conjunctive Normal Form]]

> [!info] In other words
> We use normal forms to 
> 1. translate a truth table into a boolean function
> 2. Make functions easier to implement in circuits
### Disjunctive Normal Form
A formula in Disjunctive Normal Form of a function f , is a logical formula which is a disjunction of conjunctive clauses representing f. 
**It is an OR of ANDs, a sum of products.**

> [!abstract] Construction
> It can be constructed by the disjunction (OR) of terms where f holds 1 in its truth table. 
> Each term is the product (AND) of variables names of f , negated if the variable is 0.

> [!example]
> $f = abc + \bar a \bar cb$
### Conjunctive Normal Form
A formula in Conjunctive Normal Form of a function f , is a logical formula which is a conjunction of disjunctive clauses representing f . 
**It is an ANDs of ORs, a product of sums.**

> [!summary] Construction
> It can be constructed by the conjunction (AND) of terms where f holds 0 in its truth table. Each term is the sum (OR) of variables names of f , negated if the variable is 1.

> [!example]
> $f = (a+b+c).(\bar a +\bar c+b)$

### Equivalence between Boolean Functions or Expressions
> [!Attention]
> 1. Two Boolean functions are equivalent if they have the same truth table
> 2. Two arithmetic Boolean expressions are equivalent if they can be rewritten to a same third expression 
> 3. The Conjunctive Normal Form can be obtained from the Disjunctive Normal Form using the Involution law f = f

> [!example]
> ![[Pasted image 20251013151228.png]]
> >[!danger] REMEMBER THIS!!
> > You have to write the name of the conversion that you performed

## Logic Gates
![[Pasted image 20251013163319.png]]

### Increment Adder
This is a more advanced way of doing addition from what is seen in [[td2.pdf|exercise 4 in td2]].
![[Pasted image 20251014002018.png]]

Its a simple idea, where it adds the [[#Carry in & out|carry in's]] inside a buffer as long as we are reading.
1. The block on the right is the buffer holding the value of the sum.
2. The CK `CLOCK` signal happens turns on every interval of time 
   ![[Pasted image 20251014002335.png]]
   The arrow indicates when the signal is triggered for reading. It could up the left edge or down the left edge, or both.  
3. WE: when `WRITE ENABLED` flag is on (and CK), we write whatever is in $D_{in}$ to the buffer and send $D_{out}$ to be summed with $C_{in}$
4. $C_{in}$ is the carry in bit to be added with the current value of $D_{out}$, then placed in $D_{in}$
5. $D_{in}$ is the sum of $D_{out} + C_{in}$ to be placed in the buffer when WE and CK are active
6. $D_{out}$ is the value of the summing buffer

**HIGHLY RECOMMEND YOU CHECK THE SOLUTION FOR EXERCISE 5 IN [[td 2 Solutions]]**
![[Pasted image 20251014002946.png]]
