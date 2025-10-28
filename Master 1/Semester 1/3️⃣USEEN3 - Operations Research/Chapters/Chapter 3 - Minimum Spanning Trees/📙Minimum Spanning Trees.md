> [!info] Definition: Weighted graph
> In a graph where every edge e in the set of edges E, the cost c(e) = cost/weight/length of e
# Minimum spanning tree
A minimum spanning tree is when we have a weighted graph and we want to find the tree from the graph with a minimal cost.

> [!info] Concrete definition
> - Input: a graph G and cost $c_e$ for each edge $e \in E$
> - Output: A spanning tree $T \subset E$ of G with min sum $\large \sum_{c_e \in T} c_e$ of edge costs.
> > [!warning] Assumption!
> > The input graph is connected with at least one path between each pair of vertices

> [!example] Example: Finding the minimum spanning tree
> ![[Pasted image 20251028115853.png| 400]]


## Prim's Algorithm
This is a greedy algorithm (which can be seen as a graph search algo) for finding the MST of a graph.

It begins by choosing an arbitrary vertex, construct the tree one edge at a time where in each iteration it adds the cheapest edge that extends the reach of the tree.

> [!info] Definition: Greedy algorithm
> An algorithm is greedy when it takes the best choice presented in the current step without considering later steps

The algorithm is as follows:
```py
X := [s] # X is the explored vertices where s is a randomly chosen vertex
T := empty # invariant: the edges in T span X

while there is an edge (v,w) with v in X, w not in X do
	(v, w) := a minimum-cost such edge
	add vertex w to X
	add edge (e, w) to T
return T
```

> [!example] Execution Example
> ![[Pasted image 20251028141712.png]]

The **complexity** of the algorithm is as follows:
- **In a straight forward implementation:** $$\Large \color{cyan} O(n^2)$$
  *We get this since we go over all the vertices once, and at most in the final iteration we do n searches*
- **In a heap based implementation:** $$\Large \color{cyan} O((n+m)log(n))$$
## Kruskal's Algorithm
Almost the same as [[#Prim's Algorithm]]. But rather than growing a single tree from a starting vertex, this algo can grow **multiple trees in parallel** until the end of the algorithm where a single tree is obtained. It considers the edges of the input graph one by one, from cheapest to most expensive.

> [!example]
> We simply sort the edges in ascending order. Then go through the list and add the edge if it does not form a cycle.
> ![[Master 1/Semester 1/3️⃣USEEN3 - Operations Research/Chapters/Chapter 3 - Minimum Spanning Trees/📚Documents/Pictures/Untitled.jpeg]]

> [!bug] I forgor to take pic of the algo T_T

The algo's **complexity** is as follows:
- A straightforward implementation: $$\Large \color{cyan} O(mlog(m) +nm)$$
  *The $mlog(m)$ is the amount of time to sort the list*
- In a Union-Find based implementation: $$\Large \color{cyan} O(mlog(m) + (n+m)log(m))$$
