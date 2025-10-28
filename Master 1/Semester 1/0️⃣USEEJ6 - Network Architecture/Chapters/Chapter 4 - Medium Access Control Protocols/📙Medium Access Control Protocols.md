The medium access control protocols (MAC) are part of the data link layer. It provides flow control and multiplexing for the transmission medium. In other words it helps avoid collisions with other packets sent by other devices

> [!info] Definition: Collision 
> **collision** happens if multiple users transmit signals on the same channel set at the same time, in which case the data is lost / merged in an incoherent mess.

# Multiplexing

Users’ data are multiplexed on a channel (wired or wireless) so that the number of collisions is minimized.
 ![[Pasted image 20251028164545.png]]

Multiplexing can be performed: 
- Either by relying to [[#Random Access Protocols|random access]]: [[#ALOHA|ALOHA]], [[#CSMA/CD|CSMA-CD]], [[#CSMA/CA|CSMA-CA]],… 
	- Simple, does not require a centralizer 
	- Collisions may occur 
	- No delay guarantee: not efficient for time-constrained applications 
- Or by using strictly [[#Channelization Access Protocols|orthogonal fixed channel resources]] : [[#TDMA|TDMA]], [[#FDMA|FDMA]], [[#CDMA|CDMA]],… 
	- More complex 
	- No collision 
	- But requires a centralizer 

# Random Access Protocols
In these protocols any device has right to send signals to the station at any time it wants. Without the station controlling these devices method of sending signals. 

This leads to a lot of collision since each device has no idea what the other devices are sending, so most of the protocols rely and trial and error. 
## ALOHA
In this protocol we send at whatever time we want. But in case  while you are transmitting data, you receive any data from another station, there has been a message collision. 
**All transmitting stations will need to try resending later.**

![[Pasted image 20251028165853.png|300]]
![[Pasted image 20251028171340.png|300]]
### Slotted ALOHA
To reduce collisions, instead of sending at whatever time, a station can only transmit at the beginning of a time slot.
![[Pasted image 20251028171506.png]]
## CSMA/CD
In **Carrier-sense multiple access with collision detection (CSMA/CD)**; stations first sense the channel to check if it is being used by another station for data transmission or if it is free:
- If the channel is free, the station sends data and listens to the channel to check any collision 
- If the channel is being used, the station waits 

A collision occurs if two stations sensed that the channel is free and sent data at the same time: 
- Then both stations send a jam signal instead of data to inform the other stations of the collision 
- Therefore, the receiving stations will discard the packets that were corrupted by the collision. 

When a collision is detected, both stations wait for a random amount of time until they retransmit again 

> [!example]
 ![[Pasted image 20251028172325.png|300]]
 ![[Pasted image 20251028172346.png|300]]

> [!info] What is sensing
> Its just checking if the user can see any signals from other users without accepting them.

> [!summary]
> ![[Pasted image 20251028172812.png]]

### Binary exponential back-off
The random waiting time is given by: $$\Large Backoff \approx Uniform(0, \space 2^k-1)*slot \space time$$
Where k is the number of transmission attempts (max: 10)

> [!example]
> 1st collision: backoff ∈ [0, 1] 
> 2nd collision : backoff ∈ [0, 3] 
> 3rd collision : backoff ∈ [0, 7] 
## CSMA/CA
**Carrier Sense Multiple Access with Collision Avoidance (CSMA/CA) protocol** has a similar principle as in [[#CSMA/CD|CSMA/CD]], but with additional messages/probes to detect if the medium is available, and avoid collisions.

There are multiple ways we can implement CSMA/CA:
- [[#DCF|DCF: Distributed Coordination Function]]
- [[#CW|CW: Contention Window]]
- [[#RTS/CTS|RTS/CTS: Ready to send/Clear to send]]

> [!warning] Hidden terminal problem
> Collision Detection is impossible in wireless (# Ethernet) because 2 nodes who want to transmit to the same node may not detect each other.
> ![[Pasted image 20251028174715.png]]

### DCF
In **Distributed Coordination Function**, without any certainty that the medium is actually free because of hidden terminal problem, stations transmit when they think the medium is free.
![[Pasted image 20251028175843.png|600]]
### CW
If a collision occurs, stations wait for a random delay before they can retransmit. It is called **Contention window**. It is a random number number between **CWmin** and **CW size**.

Whenever a transmission fails, then double **CW size** until **CW size** reaches **Cwmax**.

So in summary: $$\color{orange }\Large CW_{min} \le CW \le CW_{size} \le CW_{max}$$
> [!example]
> Example: CWMin = 15 and CWMax = 1023 
> - 1st transmission (even without collision) : backoff ∈ [0, 15] 
> - 1st collision: backoff ∈ [0, 31] 
> - 2nd collision : backoff ∈ [0, 63] 
> - 3rd collision : backoff ∈ [0, 127] 
> - *Until backoff ∈ [0, 1023]* 

> [!info] SIFS and DIFS ^DIFSandSIFS
> - **SIFS Short Inter-Frame Spacing:** Delay before each frame in the same exchange. Between RTS and CTS, CTS and data, data and ACK.
> - **DIFS Distributed Inter-Frame Spacing:** Delay before each new frame in different exchanges.

> [!summary] Summary and example:
> If the medium is free: Directly transmit data.
> Else: 
> - Wait until the medium becomes free. 
> - And wait for [[#^DIFSandSIFS|DIFS]] (fixed) and Contention Window (random).
> 
> Then: 
> - If the medium is free, transmit. 
> - Else, wait until next free medium period. Store the remaining CW and only wait for this time at next access request. 
> ![[Pasted image 20251028181227.png]]
### RTS/CTS
![[Pasted image 20251028181420.png]]
This way, nodes near to the transmit node or to the destination node become aware of the transmission -> To avoid hidden terminal problem 

> [!attention]
> The NAV (approximate transmission time) is sent both by the transmit and destination node so that the other nodes can wait during transmission

> [!example]
> In this example:
> - B can detect A and C. 
> - A cannot detect C. 
> - D can only detect A.
> ![[Pasted image 20251028181830.png]]

> [!Warning]
> CW is not only for data! We add it as well if there was a collision in RTS, CTS, or whatever signal the user has sent!
# Channelization Access Protocols
Channelization is a multiple-access method in which the available bandwidth of a link is shared in time and frequency, or through code, between different stations.
## TDMA

## FDMA

## CDMA
