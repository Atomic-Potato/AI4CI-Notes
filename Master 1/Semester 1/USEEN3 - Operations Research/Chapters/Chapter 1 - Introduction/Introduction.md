
> [!info] Books
> - The Algorithms Illuminated Book Series, Tim Roughgarden, 2017. 
> - Algorithm Design, Eva Tardos and Jon Klein, 2005. 
> - Network Flows : Theory, Algorithms, and Applications, Ravindra Ahuja, Thomas Magnanti, James Orlin, 1993

# Types of algorithm analysis
- **Worst-Case Analysis :** gives a running time bound that is valid even for the “worst” inputs 
- **“Big-picture” analysis :** balance predictive power with mathematical tractability by ignoring constant factors and lower-order terms 
- **Asymptotic Analysis :** focus on the rate of growth of an algorithm’s running time, as the input size n grows large

# Asymptotic notation
*A fast algorithm is an algorithm whose worst-case running time grows slowly with the input size.*

This notation suppress:
1. **constant factors** *(too system-dependent)* 
2. **and lower-order terms** *(irrelevant for large inputs)*

> [!faq] What is a lower order term?
> It refers to any term in a function that grows **slower** than the dominant (highest-order) term.
> 
> For example: $f(n)=3n^2+5n+2$
> $3n^2$ is a higher order than $5n$ and $2$

## Big $O$ notation
For a complexity function T(n) defined on the positive integers $n \in \mathbb{N}$:
$\large \color{red} T(n) = O(f (n))$ **if and only if $T (n)$ is eventually bounded above by a constant multiple of $f (n)$.**
![[Pasted image 20251011163207.png]]
*T(n) will denote a bound on the worst-case running time of an algorithm, as a function of the size n of the input.*

> [!hint]
> Its best if we find the a function $f(n)$ with the lowest possible order to satisfy our condition

### Alternative mathematical definition
$\large \color{red} T (n) = O(f (n))$ if and only if there exist positive constants c and n0 such that $\large \color{blue} T (n) \le cf (n)$ for all **n ≥ n0**

> [!warning] Note
> c and n0 are constants, they cannot depend on n.

**So to prove this definition for any function, then:** ^proofO
1. Find the constant $c$
2. Find the first $n_0$

That satisfies $\large \color{red} T (n) ≤ cf (n)$
## A property of big $O$
> **Suppose $\Large \color{purple} T(n) = a_k n^k + · · · + a_1n + a_0$, then $\Large \color{purple} T(n) = O(n^k)$.** 
> *Where k ≥ 0 is a non negative integer and the $a_i$ ’s are real numbers (positive or negative).* 

### Proof:
We just need to find and $c$ and $n_0$
we have $T(n) = a_k n^k + · · · + a_1n + a_0$

1. we know that $T(n) \le cf(n) \space \forall n=n_0$, we need to get $f(n)$ to the form of $n^k$
2. first $T(n) \le |a_k| n^k + · · · + |a_1n| + |a_0| \space \forall n \ge 0$
3. and $T(n) \le (|a_k| + · · · + |a_0|)n^k \space \forall n \ge 1$ 
   (**note:** we replaced each $n^i$ with $n^k$ and took it as a common factor)

and so we found: 
1. $c = |a_k| + · · · + |a_0|$
2. $n_0 = 1$

## Omega $\Omega$ notation
$\Large \color{red} T (n) = \Omega(f (n))$ if and only if there exist positive constants c and n0 such that $\color{blue} \large T (n) \ge cf (n)$ for all **n ≥ n0**

## Theta $\Theta$ notation
$\Large \color{red} T (n) = \Omega(f (n))$ if and only if there exist positive constants c1, c2 and n0 such that $\color{blue} \large c_1f (n) \le T (n) \le c_2f (n)$ for all **n ≥ n0**

# Miscellaneous
> - **Elementary Operation:** it is a comparison in your code *(e.g. A[i] = t)*
> - Algorithm designers often use $O$ notation even when $\Theta$ notation would be more accurate
> - The running times of different algorithms on inputs of increasing size, for a processor performing a million high-level instructions per second.
>   ![[Pasted image 20251011181505.png]]

## Finding proof for some properties
### Adding a constant to an exponent
We need to show that: $$\Large \color{purple} x^{n+c} \in O(x^n)$$
**Proof (by me, so double check my dumbass):**
1. we must find c and n0 such that $\large x^{n+c}\le c_1x^n \space \forall n \ge n_0$ and $c1 \gt 0$
2. $\large x^{n+c}=x^n.x^c \le c_1x^n$
3. taking $x^n$ from both sides implies $\large x^c \le c_1$
4. and so any c greater or equal than $x^c$  and n0 = 0 proves our property
### Multiplying an exponent by a constant
We need to show that: $$\Large \color{purple} x^{n*c} \in O(x^n)$$
**Proof (by me, so double check my dumbass):**
1. we must find c and n0 such that $\large x^{n*c}\le c_1x^n \space \forall n \ge n_0$ and $c1 \gt 0$
2. $\large x^{n*c}=x^{n_c}*x^{n_{c-1}}*...*x^{n_0} \le c_1x^n$
3. taking one $x^n$ from the left and from the right, we get: $\large x^{n_{c-1}}*...*x^{n_0} \le c_1 \Rightarrow x^{n(c-1)} \le c_1$
4. And so we have our C and n0 = 0

### Max Vs. Sum
We need to show that: $$\Large \color{purple} T(n) = O(max\{f(n),g(n)\}) = O(f(n)+g(n))$$
**Proof (by me, so double check my dumbass):**
1. Let's consider $f(n)=a_kn^k+...+a_0$ and $g(n)=b_jn^j+...+b_0$ and $T(n)=f+g$
2. Lets show that $T(n)= O(h(n))$
3. we know that $T(n)\le (|a_k|+...+|a_0|)n^k + (|b_j|+...+|b_0|)n^j \space \forall n\ge 1$
4. Now depending on the max between k and j, we will have our constant (either the a's or b's) because we wanna take the highest order.
5. And so we can deduce from [[#A property of big $O$|this property]] that $T(n) = O(max(n^k,n^j))$ hence $T(n) = O(max\{f(n),g(n)\}) = O(f(n)+g(n))$

