In the big O notation, we ignore the constants and only focus on the variables, so if you have a complexity of $3n^2 + n + 2$, your O notation is $O(n^2)$. O is an approximation of the worst case scenario.

*Example:*
```
for i = 1 to n do
	if A[i] = t then
		return true
return false
```

For the worst case scenario here we have **n comparisons**

We want to find the smallest bound for T(n)