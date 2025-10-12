# Introduction
> [!hint]
> Not exactly important
## Compilation Process
![[Pasted image 20251006095611.png|600]]
## Information Encoding
Information encoding = link between the external (natural) representation of information (character ’A’ or number 36) and its binary representation (sequences of bits: 0010 0100)

# Base systems
## Base notations
![[Pasted image 20251008141802.png|500]]

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

# Miscellaneous
- The most significant bit `(MSB)` is to the left, and the least significant bit `(LSB)` is to the right *(This applies for any base)* ^sb

