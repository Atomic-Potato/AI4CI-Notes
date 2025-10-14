In a graph, we cant cross each edge once if there is a node with an odd number of edges.

# Types of graphs
- **Directed:** The edges have an orientation (one way to cross). *We also call them "arcs"*
- **Undirected:** Edges have no orientation (2 ways). *We also call them "edge"* ^undirected

# Basic Definitions & Terms
- V is set of **vertices** where **n is the total count**
- E set of **edges** where **m is the total count**
- **Eulerian cycle** is a cycle through the graph that starts and ends on the same node.
# Directed graphs
- A direct graph $G = (V, E)$
- **Tails and heads:** an arc has 2 endpoints **i (tail)** and **j (head)**, where the arc (i,j) is **outgoing** from i, and **incoming** to j
  ![[Pasted image 20251014102100.png|200]]
- **Degrees:** The **indegree** $d^-(i)$ is the nb of incoming arcs of the node i, and the **outdegree** $d^+(j)$ is the nb of outgoing arcs of the node j. $d(i) = d^-(i) + d^+(i)$ ^c41ada

> [!info] Property
> 1. The sum of indegrees equals the sum of outdegrees equals the nb of arcs $$\sum d^-(i) = \sum d^+(i) = m$$ $$d(i) = 2m$$

# Paths and Cycles
- A **path:** in an [[#^undirected|undirected]] graph is a sequence *P* of vertices $(v_1, ...., v_k)$ where each consecutive pair $v_i, v_{i+1}$ is joined by an edge *E*
- A path is **simple:** if all vertices are distinct
- A **cycle:** is path in which the first and last nodes are equal (**where the path has more than 2 nodes**) and the vertices in between are all **distinct.**

> [!example]
> ![[Pasted image 20251014221248.png]]


# Connectivity
An undirected graph may be made of disconnected pieces, which are called **connected components** *(even if the component is a single node)*

> [!info] Formal Definition
> A **connected component** is a maximal subset S of the vertices V, such that there is a path from any vertex in S to any other vertex in S

> [!example]
> ![[Pasted image 20251014221532.png]]


# Trees !!!!!
An undirected graph is a tree if it is connected and does not contain a cycle.

> [!tip] Properties
> For any tree G, any of the 2 following statements imply the thrid:
> - G is connected
> - G does not contain a cycle
> - G has n-1 edges

## Rooted Trees
To make a graph into a rooted tree:
1. choose a root node r
2. orient each edge away from r

This would give you a hierarchical structure.
![[Pasted image 20251014222722.png|600]]

# Measuring the size of a graph
In an undirected graph with n vertecies and no parallel edges (2 nodes having multiple edges):
1. min number of edges = $n-1$
2. max number of edges = $\large \frac{n(n-1)}{2}$

A graph is:
- **Sparse** if the number of edges is relatively close to linear in the number of vertices ^c0d6c8
- **Dense** if this number is closer to quadratic in the number of vertices ^1e7b2b

# Representing a graph in memory
## Adjacency list
1. We create an array equal to the nb of vertices, where each index of the array represents a vertex
2. For each cell, we store pointers for each of the incident edges

> [!example]
> ![[Pasted image 20251014224149.png]]
> *mmmm, hand*

**Size required in memory:**
1. **Array size =** $\Theta(n)$ 
2. **for all of the adjacency lists =** $\Theta(\sum d(x)) = \Theta(2m) = \Theta(m)$ 
- **Total size =** $\Theta(n+m)$ **tightest correct bound** 

> [!danger] Attention!
> For the total size:
> - $\Theta(n+m)$ is the tightest **correct** bound
> - $O(n*m)$ is the tightest and **correct but inaccurate** bound
> - $\Theta(n*m)$ is an **incorrect** tight bound, because its impossible to reach it

>[!tldr] Reminders:
> - [[📙Introduction#Big $O$ notation (upper bound)|Big O notation]]
> - [[📙Introduction#Theta $ Theta$ notation (exact bound)|Big Theta notation]]

## Adjacency Matrix
We create a square $n \times n$ matrix A, with 0s and 1s for entries. The rows and columns indices represent the vertices, and for each cell we set it to 1 if there is an edge between the row and column nodes.

> [!example]
> ![[Pasted image 20251014230352.png]]
> *sowy for blurry image >_<*

**Size required in memory:**
- For the whole array we need $\Theta(n^2)$

## List Vs. Matrix
Which kind do wish to use depends on some factors:
- **In terms of size:**
	- When its [[#^1e7b2b|dense]]: $\Theta(n^2) \le \Theta(n+m)$ (so matrix)
	- When its [[#^c0d6c8|sparse]]: $\Theta(n+m) \le \Theta(n^2)$ (so list)
- **In terms of speed to find an edge:**
	- Matrix = $\Theta(1)$
	- List = $\Theta(d(x))$ where $d(x) = \Theta(min(n,m))$
- **The nb of operation to find the nb of incoming edges on a node:**
	- Matrix = $\Theta(n)$
	- List = $\Theta(n+m)$


> [!tldr] Reminder
> [[#^c41ada|Degrees]]


