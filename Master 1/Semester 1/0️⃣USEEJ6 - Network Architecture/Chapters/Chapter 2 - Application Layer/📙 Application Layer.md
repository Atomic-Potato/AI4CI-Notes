***Table of contents***
1. [[#What this layer defines|What this layer defines]]
2. [[#What is HTTP|What is HTTP]]
	1. [[#What is HTTP#HTTP 1.0 vs HTTP 1.1|HTTP 1.0 vs HTTP 1.1]]
		1. [[#HTTP 1.0 vs HTTP 1.1#Non-persistent HTTP 1.0 issues:|Non-persistent HTTP 1.0 issues:]]
		2. [[#HTTP 1.0 vs HTTP 1.1#Persistent HTTP (HTTP1.1):|Persistent HTTP (HTTP1.1):]]
	2. [[#What is HTTP#HTTP/2|HTTP/2]]
		1. [[#HTTP/2#Problems with HTTP/1.1|Problems with HTTP/1.1]]
		2. [[#HTTP/2#HTTP/2 Advantages|HTTP/2 Advantages]]
3. [[#DNS|DNS]]
	1. [[#DNS#Root server and different levels|Root server and different levels]]
	2. [[#DNS#Local DNS|Local DNS]]
	3. [[#DNS#DNS name resolution|DNS name resolution]]
		1. [[#DNS name resolution#iterated query|iterated query]]
		2. [[#DNS name resolution#recursive query|recursive query]]
	4. [[#DNS#Caching DNS Information|Caching DNS Information]]
	5. [[#DNS#DNS Records|DNS Records]]
		1. [[#DNS Records#Types of records|Types of records]]
	6. [[#DNS#DNS protocol messages:|DNS protocol messages:]]
4. [[#From Report Lab 1 HTTP & DNS Lab1]]
	1. [[#BGP Protocol|BGP Protocol]]
		1. [[#BGP Protocol#How it works|How it works]]
	2. [[#EDNS0 Client-Subnet|EDNS0 Client-Subnet]]


# What this layer defines
- types of messages exchanged, • e.g., request, response § 
- message syntax: what fields in messages & how fields are delineated 
- message semantics: meaning of information in fields 
- rules for when and how processes send & respond to messages
- open protocols: defined in RFCs, everyone has access to protocol definition; allows for interoperability: e.g., HTTP, SMTP 
- proprietary protocols: e.g., Zoom

# What is HTTP

## HTTP 1.0 vs HTTP 1.1
**Most importantly HTTP 1.1 keeps the connection open after the first request to send others, while 1.0 gets closed after the first request, as well as flexible cache control.**

### Non-persistent HTTP 1.0 issues: 
- requires 2 RTTs per object 
- OS overhead for each TCP connection 
- browsers often open multiple parallel TCP connections to fetch referenced objects in parallel

### Persistent HTTP (HTTP1.1): 
- server leaves connection open after sending response 
- subsequent HTTP messages between same client/server sent over open connection 
- client sends requests as soon as it encounters a referenced object 
- as little as one RTT for all the referenced objects (cutting response time in half)

some other differences:
![[Pasted image 20251004140819.png]]

## HTTP/2
**The main goal of HTTP/2 is to decrease delay in multi-object HTTP requests**
### Problems with HTTP/1.1
HTTP1.1 introduced multiple, pipelined GETs over single TCP connection:
- server responds in-order (FCFS: first-come-first-served scheduling) to GET requests 
- with FCFS, small object may have to wait for transmission (head-of- line (HOL) blocking) behind large object(s) 
- loss recovery (retransmitting lost TCP segments) stalls object transmission
### HTTP/2 Advantages
HTTP/2 increased flexibility at server in sending objects to client: 
- methods, status codes, most header fields unchanged from HTTP 1.1 
- transmission order of requested objects based on client-specified object priority (not necessarily FCFS) 
- push unrequested objects to client 
- divide objects into frames, schedule frames to mitigate HOL blocking

# DNS
The Domain Name System is used to find the IP address of a requested domain name.
## Root server and different levels
![[Pasted image 20251004183049.png|800]]
Client wants IP address for www.amazon.com 1st approximation:
- **Root name servers:** client queries root server to find .com DNS server:  
  *Usually the client contacts the root DNS server as a last resort when they cannot find the IP in a local DNS server.* 
- **Top-Level Domain (TLD) servers:**: client queries .com DNS server to get amazon.com DNS server
  *Responsible for .com, .org, .net, .edu, .aero, .jobs, .museums, and all top-level country domains, e.g.: .cn, .uk, .fr, .ca, .jp*
- **authoritative DNS servers:** client queries amazon.com DNS server to get IP address for www.amazon.com
  *Organization’s own DNS server(s), providing authoritative hostname to IP mappings for organization’s named hosts*
## Local DNS
When host makes DNS query, it is sent to its local DNS server. Local DNS server returns reply, answering from its local cache of recent name-to-address translation pairs (possibly out of date!) or forwarding request into DNS hierarchy for resolution
> [!info]
>  each ISP has local DNS name server; to find yours: 
>  - MacOS: `% scutil --dns`
>  - Windows: `>ipconfig /all`

> [!warning] Note:
>  local DNS server doesn’t strictly belong to hierarchy

## DNS name resolution
### iterated query
![[Pasted image 20251004184725.png]]

### recursive query
![[Pasted image 20251004184749.png]]

## Caching DNS Information
once (any) name server learns mapping, it caches mapping, and immediately returns a cached mapping in response to a query

- cache entries timeout (disappear) after some time (TTL)
- TLD servers typically cached in local name servers

> [!Warning] Note
>  cached entries may be out-of-date if named host changes IP address, may not be known Internet- wide until all TTLs expire!

## DNS Records
The DNS stores information in a distributed database as **resource records (RR)**
With this format `(name, value, type, ttl)`
### Types of records
![[Pasted image 20251004185445.png]]

## DNS protocol messages:
DNS query and reply messages, both have same format:
![[Pasted image 20251004185513.png|700]]
![[Pasted image 20251004185524.png|700]]
## From [[Report Lab 1 HTTP & DNS|Lab1]]
### BGP Protocol
BGP is the **interdomain routing protocol** of the Internet, classified as a **path-vector protocol**. It determines the **best path** for packets to travel between autonomous systems **(AS)**. So BGP **routes your DNS query** to a resolver or authoritative server that is topologically closest — improving latency and redundancy.

**AS**: Each ISP, big company, or data center network is an AS (with a unique AS number).


#### How it works
BGP routers exchange reachability information: _“I can reach this IP prefix via me.”_ This info includes the full path of AS numbers the route passes through (hence “path-vector”).
> [!warning]
> BGP doesn’t just pick the _shortest path_; it considers policies (e.g., cost, business agreements, security).

### EDNS0 Client-Subnet
Simply the DNS includes a subnet indicating the area of the user IP, so when the CDN/Resolver returns an address to the DNS, it returns an edge node (proxy/cache holding the data), i.e. the closest one.