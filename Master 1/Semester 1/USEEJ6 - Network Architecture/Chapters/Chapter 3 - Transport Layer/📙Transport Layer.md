> [!info] What you are probably looking for! :D
> For the exercises you may only need to know:
> - [[#Reliable data transfer with cumulative ACKS|TCP Cumulative ACKs]]
> - [[#Congestion Control|TCP Congestion Control]]


# What is this layer
> **This layer provides logical communication between application processes running on different hosts**

The **sender** breaks application messages into segments, passes to network layer.
While the **receiver** reassembles segments into messages, passes to [[📙 Application Layer|application layer]]

## Transport Vs. Network layer
`Transport layer` handles communication between processes (Applications). While `network layer` communication between hosts (Servers)

## Transport layer protocols
two transport protocols available to Internet applications: TCP, UDP
### TCP
Transmission Control Protocol:
- reliable, in-order delivery 
- congestion control 
- flow control 
- connection setup
### UDP
User Datagram Protocol: 
- unreliable, unordered delivery 
- no-frills extension of “best-effort” IP

More info in this section: [[#UDP User Datagram Protocol]]

# Multiplexing and Demultiplexing
Multiplexing and demultiplexing allows the transport layer to deliver the message to the correct application process

## **Multiplexing as a sender:** 
handles data from multiple sockets, add transport header
  ![[Pasted image 20251012115319.png|300]]
## **Demultiplexing as a receiver** 
uses header info to deliver received segments to correct socket
![[Pasted image 20251012115252.png|300]]
Each received datagram has the sender app port and the server app port. Host uses IP addresses & port numbers to direct segment to appropriate socket
![[Pasted image 20251012115907.png]]
> [!warning] UDP vs TCP
> - [[#UDP]]  does demultiplexing using destination port number (only)
> - [[#TCP]] does  demultiplexing using 4-tuple: source and destination IP addresses, and port numbers
### Connectionless demultiplexing (UDP)
All segments sent to the same port are assigned the **same socket**
 ![[Pasted image 20251012123544.png]]
### Connection Oriented demultiplexing (TCP)
All segments sent to the same port are assigned **different sockets**
![[Pasted image 20251012124101.png]]

# UDP: User Datagram Protocol
UDP is ***connectionless***, that is no handshaking between UDP sender, receiver; and each UDP segment handled independently of others 

A UDP **segment structure** is as follows:
![[Pasted image 20251012124826.png|400]]

**The UDP sender:**
1. is passed an [[📙 Application Layer|application layer]] message 
2. determines UDP segment header fields values
3. creates UDP segment 
4. passes segment to [[Network Layer|IP]]

**The UDP Receiver:**
1. receives segment from [[Network Layer|IP]]
2. checks UDP checksum header value
3. extracts [[📙 Application Layer|application layer]] message
4. demultiplexes message up to application via socket

> [!missing]
> We did not discuss how reliable data transfer works for UDP in this course. But only for [[#TCP Transmission Control Protocol|TCP]]
## Checksum
The goal of a checksum is to detect if there was an error in the received bits (a flipped bit) of the segment.

**How it works:**
1. Treat the contents of the segment as chunks of 16-bit integers
2. Add all the chunks together
3. Complement the sum
4. send the the segments and the sum
5. The receiver sums the segments and checks if it is equal to the received checksum

> [!hint] Reminder
> How to do binary addition: [[📙Number Representation and Boolean Function#Base 2 Binary|Binary addition]]

> [!example] Example of calculating the check sum
> ![[Pasted image 20251012130311.png]]

# TCP: Transmission Control Protocol
TCP is **connection oriented**,  handshaking (exchange of control messages) initializes sender, receiver state before data exchange. It is [[#Congestion Control|handles congestion]], that is sender will not overwhelm receiver. And uses **cumulative ACKs** for [[#Reliable data transfer with cumulative ACKS|reliable data transfer]].

A TCP **segment structure** is as follows:
![[Pasted image 20251012140455.png]]
- **Sequence numbers:** It is index number of the first byte in the segment ^sqnb
- **Acknowledgements:** It is the sequence number of the next byte that is expected from the other end (sender/receiver) ^ack
- more about flags in [[#Flags]]


> [!faq] how receiver handles out-of- order segments?
> TCP spec doesn’t say, - up to implementor

> [!caution] Variable header length!
> Note that the segment length can vary! So pay attention in [[#Reliable data transfer with cumulative ACKS|cumulative ACKs]]! But generally in exercises its always the same segment length. 

## Reliable data transfer with cumulative ACKS
> [!missing] MISSING: RTT
> Calculating a timeout is seen in the course PDF, but was ignored during the lecture and the exercises

Basically we send a number of segments based on the window size (which we see in [[#Congestion Control]] but never actually use here). And we make sure these segments are received on the other end. 

I am a lazy bum so i will explain with pictures.
![[Pasted image 20251012142647.png]]
1. Starting with some [[#^sqnb|sequence number]], we send the length of the segment. **No need to acknowledge anything to the receiver for the first segment.**
2. For the first segment the receiver gets, they reply with an **ACK = Seq nb + size of data**
- **IF** the sender sends again a segment again for any reason, then if the last ACK is greater than the received Seq nb, then we resend the same ACK as last.
- The sender always continues from the latest ACK even if it did not receive the previous ACKs
  ![[Pasted image 20251012142240.png]]
- **IF** sender receives 3 additional ACKs for same data (“triple duplicate ACKs”), resend unACKed segment with smallest seq # (likely that unACKed segment lost, so don’t wait for timeout)
  ![[Pasted image 20251012145044.png]]
## Congestion Control
> [!Missing] MISSING: Flow Control
> We did not discuss Flow Control during the lecture (it is found in the PDF however). Instead only congestion control.

Congestion happens when too many sources are sending too much data too fast for the [[Network Layer|network layer]] to handle.

For this we send use a combination of TCP [[#Slow Start and congestion control]] and [[#AIMD Additive Increase Multiplicative Decrease|Additive Increase Multiplicative Decrease]].

> [!Info] Definitions
> - **MSS:** Maximum segment size, i.e size of data in each segment (in bytes) ^mss
> - **cwnd:** Congestion window; how many segments to send per transmission; starts with 1 MSS ^cwnd
> - **ssthresh:** slow start threshold; threshold when the cwnd increase switches from exponential to linear ^ssthresh

### AIMD: Additive Increase Multiplicative Decrease
![[Pasted image 20251012155224.png]]
- **On Triple ACK:** set [[#^ssthresh|ssthresh]] = cwnd/2 **AND** cut [[#^ssthresh|cwnd]] by half
- **On timeout:** set [[#^ssthresh|ssthresh]] = cwnd/2 **AND** set [[#^ssthresh|cwnd]] to 1 [[#^ssthresh|MSS]]
### Slow Start and congestion control
1. set [[#^ssthresh|cwnd]] to 1 [[#^ssthresh|MSS]] 
2. For each new transmission, double `cwnd` size
3. When `cwnd` reaches `ssthresh`, it starts increasing linearly (1 by default) instead of exponentially
![[Pasted image 20251012160416.png|600]]
# Flags
> [!info] 
> I simply yoinked everything in this page:
> https://www.geeksforgeeks.org/computer-networks/tcp-flags/

In TCP connection, flags are used to indicate a particular state of connection or to provide some additional useful information like troubleshooting purposes or to handle a control of a particular connection. Most commonly used flags are **"SYN", "ACK" and "FIN"**. Each flag corresponds to 1 bit information.   
  
**Types of Flags:**   
- **Synchronization (SYN) -** It is used in first step of [connection establishment](https://www.geeksforgeeks.org/computer-networks/tcp-connection-establishment/) phase or 3-way handshake process between the two hosts. **Only the first packet from sender as well as receiver should have this flag set.** This is used for synchronizing sequence number i.e. to tell the other end which sequence number they should accept.
- **Acknowledgement (ACK) -** It is used to acknowledge packets which are successful received by the host. The flag is set if the acknowledgement number field contains a valid acknowledgement number.   
    In given below diagram, the receiver sends an ACK = 1 as well as SYN = 1 in the second step of connection establishment to tell sender that it received its initial packet.   
     
- **Finish (FIN) -** It is used to request for [connection termination](https://www.geeksforgeeks.org/computer-networks/tcp-connection-termination/) i.e. when there is no more data from the sender, it requests for connection termination. This is the last packet sent by sender. It frees the reserved resources and gracefully terminate the connection.   
     
- **Reset (RST) -** It is used to terminate the connection if the RST sender feels something is wrong with the TCP connection or that the conversation should not exist. It can get send from receiver side when packet is send to particular host that was not expecting it. 
- **Urgent (URG) -** It is used to indicate that the data contained in the packet should be prioritized and handled urgently by the receiver. This flag is used in combination with the Urgent Pointer field to identify the location of the urgent data in the packet.
- **Push (PSH) -** It is used to request immediate data delivery to the receiving host, without waiting for additional data to be buffered on the sender's side. This flag is commonly used in applications such as real-time audio or video streaming.
- **Window (WND) -** It is used to communicate the size of the receive window to the sender. The window size is the amount of data that the receiving host is capable of accepting at any given time. The sender should limit the amount of data it sends based on the size of the window advertised by the receiver.
- **Checksum (CHK) -** It is used to verify the integrity of the TCP segment during transmission. The checksum is computed over the entire segment, including the header and data fields, and is recalculated at each hop along the network path.
- **Sequence Number (SEQ) -** It is a unique number assigned to each segment by the sender to identify the order in which packets should be received by the receiver. The sequence number is used in conjunction with the acknowledgement number to ensure reliable data transfer and to prevent duplicate packets.
- **Acknowledgement Number (ACK) -** It is used to acknowledge the receipt of a TCP segment and to communicate the next expected sequence number to the sender. The acknowledgement number field contains the sequence number of the next expected segment, rather than the number of the last received segment.