<!--*Time: 11h*-->
*Group members:*
- *Medyan MEHI ELDINE*

---
<!--
> [!info]
> For each of the exercises there's **Observation** step first showing the results of running the commands, then an **Analysis** step to showcase the underlying systems or discus the results.
-->
# EX 1: HTTP 1.0 vs HTTP 1.1
> [!info]
> We will [[#Observation|observe]] first the results of running the requests, then [[#Analysis of the difference between HTTP 1.0 and HTTP 1.1|analyse]] the difference between the two versions from these results
## Observation
### info.cern.ch
Starting off by testing the HTTP connection on `info.cern.ch` using HTTP 1.0 with the following request:
```
GET / HTTP/1.0
Host: info.cern.ch
```

The server responds with `200 OK` in **HTTP 1.1** (weirdly enough, not with **HTTP 1.0**) with some connection information,
![[Pasted image 20251004123931.png|500]]
as well as the content of the main page in html format:
![[Pasted image 20251004124046.png|500]]
And finally the telnet connection closes immediately with the message: 
*"Connection closed by foreign host."*
### google.com
#### HTTP 1.0
Sending a query to google with following request in HTTP 1.0:
```
GET www.google.com/search?q=hello+world HTTP/1.0
Host: www.google.com
```
The server responds with `200 OK` in **HTTP 1.0** with some connection information,
![[Pasted image 20251004125526.png|800]]
Accompanied by the page HTML containing the query results, and an immediate closing of the connection with the message:
*"Connection closed by foreign host."*
#### HTTP 1.1
First thing noticed when using HTTP 1.1  on the other hand, is that the connection remains open for sending more requests until closed manually:  
![[Pasted image 20251004125911.png|800]]

Secondly we notice a small change of the connection message with the addition of the `Transfer-Encoding: chunked` field at the end, and of course the page HTML of the query after.
![[Pasted image 20251004125958.png|800]]

### example.com\/test
Making a get request in either 1.0 or 1.1 results in a `404 Not Found` in their respective HTTP versions
![[Pasted image 20251004134607.png|500]]
Followed by an HTML response page (that is weirdly the same for the main page)

The only difference between the two versions is that the connection remains open for **1.1** which also had in the response message the `Connection` field set to `keep-alive`, unlike **1.0** which was set to `close`.
## Analysis of the difference between HTTP 1.0 and HTTP 1.1
From what we seen, both versions when sending a request receive back connection information followed with the HTML page to be loaded. The main difference between the two versions is 1.1 is persistent while 1.0 is not, i.e. 1.1 allows us to send more requests after opening a connection as we saw in the google domain, and got confirmed by the different values of `keep-alive` for 1.1 and `close` for 1.0 in the `Connection` field, unlike the 1.0 requests which instantly close after the first request for all the domains with the message *"Connection closed by foreign host."* meaning the server ended the connection after sending a response.

--- 
# EX 2: HTTP/2

## Browsing cnam.fr
Starting with the following curl command
```sh
curl -v --http2 www.cnam.fr
```

We get this message sent from the client:
![[Pasted image 20251004161434.png]]
The client sends a `GET` request to the main page in HTTP/1.1 asking for an upgrade to use the HTTP2 protocol.

However the server responds with:
![[Pasted image 20251004162550.png]]
A `301` error, saying the main page has been moved to `https://www.cnam.fr`, and closes the connection.
This means that not specifying the protocol in the URL, **uses HTTP (h2c) by default instead of HTTP (h2)**

> [!info] Note
> We can know if the message is from the client or server by looking at the direction of the arrows if its outgoing `>` or incoming `<`

Specifying the protocol in the URL this time:
```sh
curl -v --http2 https://www.cnam.fr > o.txt
```
*(NOTE: we are putting the HTML response only in a text document to have a cleaner output)*

We get the following output:
First the client tries and succeeds to connect to the IP address 
![[Pasted image 20251004172732.png]]

And then we see TLS handshake process between client and server: 
![[Pasted image 20251004172847.png]]
> [!info] Note
> We can know if the message is from the client or server by looking at the direction of the braces if its outgoing `}` or incoming `{`

in the end of the handshake we see this message:
***"ALPN: server did not agree on a protocol. Uses default."*** 
This implies the server did not agree to use HTTP/2 as the requests protocol, it will use instead HTTP/1.1 as we will see later on.

Next we see the information about the received server certificate:
![[Pasted image 20251004173356.png]]

Then we get to the actual data request and responses from the client and the server using HTTP/1.1
![[Pasted image 20251004173527.png]]

Finally the connection is closed by both ends
![[Pasted image 20251004173653.png]]
## Browsing wikipidea.com
For this domain, the process is the same until after the TLS handshake. This time the domain agrees to use `HTTP/2` as the communication protocol:
***"ALPN: server accepted h2"***

Now the requests are slightly different since HTTP/2 uses pseudo header (more info [here](https://cabulous.medium.com/http-2-and-how-it-works-9f645458e4b2)) which are then translated by curl to be more human readable:
![[Pasted image 20251004174759.png]]

However we can see that the server responds with `301`, it wants to redirect us to https://www.wikipedia.org instead of `.com`
And so we instead curl into the `.org` domain. Which results in the same communication process, but we also now receive some cache,
![[Pasted image 20251004175101.png]]
and some cookies are set
![[Pasted image 20251004175126.png]]

## Summary
In summary, the communication process has the following steps:
1. Connecting to the IP address
2. Performing the TLS handshake to open a connection
3. Setting a protocol to use
4. Sending requests and receiving data
5. Receiving cache and setting cookies (not always)
6. Closing the connection or keeping it alive

---
# EX 3: DNS
## My public IP
To find the host public IP, we used the following command
```sh
curl ifconfig.me
# output: 46.193.0.20
```

Reverse searching this IP with `nslookup` yields the following:
```sh
nslookup -type=A 46.193.0.20
# output:
# Non-authoritative answer:
# 20.0.193.46.in-addr.arpa	name = cust-west-par-46-193-0-20.cust.wifirst.net.
```

First we notice that it is `Non-authorative`, implying that this was returned from the cache of a local DNS server and it did not go through the different DNS levels.

Then we see the domain name of what is most likely the ISP provider.

## Comparing CNAM domains
### Type `A` 
This is the output using type `A` for each of the domains:
![[Pasted image 20251004195250.png]]

First thing we notice is that they all come from a cache in a local DNS server. And we get the output as expected for this resource record type. Which is the host name and its IP address.

### Type `MX`
This is the output using type `MX` for each of the domains:
![[Pasted image 20251004195404.png]]

Since we are using `MX` type, it means we are looking for the name of the SMTP mail server that is associated with the domain name we provide for the command.

We notice for `cnam.fr` that we receive a response from the local DNS. It has two mail servers `incoming1.cnam.fr` and `incoming2.cnam.fr`.
However both `le.cnam.net` and `roc.cnam.fr` have no answers for mail servers from a local DNS. And instead it gives us the authoritative domain which we can ask for an answer, but performing an nslookup in these domains results with the same output, meaning these domains have no mail services.

### Type `NS`
This is the output using type `NS` for each of the domains:
![[Pasted image 20251004195546.png]]

The `NS` type gives us the hostname of the authoritative server for the given domain. And as we can see for both `cnam.fr` and `roc.cnam.fr` the hostnames are cached in a local dns, `cnam.fr` having 3 hosts, while `roc.cnam.fr`  having 2. It also gives us the IPs of these domains, how nice of it :]

However, for `le.cnam.net` it did not find any domains, because its a subdomain of `cnam.net`, for which if we perform `nslookup` on we get a result:
![[Pasted image 20251004204020.png]]

## The louvre
For the `www.louvre.com` we can find it has many addresses cached in the local DNS:
![[Pasted image 20251004204304.png]]

using `curl` to test HTTP/2 on `louvre.com` we find out that it does not find a connection:
![[Pasted image 20251004205829.png]]

Trying to find again the host server, results in a timeout:
![[Pasted image 20251004210138.png|600]]

> [!Warning] Note
> In case it was the `louvre.fr` domain instead of `louvre.com` it works fine, but theres nothing new to note of, the out of the curl on `.fr` yields similar results found in [[#EX 2 HTTP/2|exercise 2]]

--- 
# Exercise 1: Request Routing in a CDN
![[part1.jpeg]]
![[part2.jpeg]]
<!-- 
The interactions table:
- T+100: User B / DNS Resolver / DNS Request / cdn.example.com
- T+100: DNS Resolver 2 / Request Router / DNS Request / cdn.example.com
- T+100: Request Router / DNS Resolver 2 / DNS Reply / 2x cdn.example.com 300 in A 2.2.2.1 / 2.2.2.2
- T+100: DNS Resolver 2 / User B / DNS Reply / 2x cdn.example.com 300 in A 2.2.2.1 / 2.2.2.2

- T+200: User C / DNS Resolver / DNS Request / cdn.example.com
- T+200: DNS Resolver 1 / User C / DNS Reply / 2x cdn.example.com 100 in A 1.1.1.1 / 1.1.1.2

- T+350: User D / DNS Resolver / DNS Request / cdn.example.com
- T+350: DNS Resolver 2 / User D / DNS Reply / 2x cdn.example.com 50 in A 2.2.2.1 / 2.2.2.2

---
Did user C receive the address of the nearest and most available proxy/cache servers? **NO**
Did user D receive the address of the nearest and most available proxy/cache servers? **NO**

---
Solutions for more optimal DNS responses:
- Decrease DNS TTL: **NO (Unless we have EDNS0)**
- Increase the number of proxy/cache servers: **NO**
- Implement EDNS0 Client-Subnet: **NO (Unless we have a TTL <= 200)**
- Cool the DNS resolvers: **NO**
- Increase the number of Request Routers: **NO**
- Use the BGP protocol: **YES**

-->