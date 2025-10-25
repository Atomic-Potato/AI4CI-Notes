# Detecting Fake Wi-Fi Access Points (Evil Twins)
## What is this problem?
When you connect to a public Wi-Fi network (like _“FreeAirportWiFi”_), your device chooses it based on the **SSID** — the human-readable network name.

But here’s the catch:  
**The SSID is not a secure identifier.**  
Anyone can broadcast a Wi-Fi network with the same SSID, often using cheap hardware or even a laptop in hotspot mode.

An attacker can exploit this by creating a **“fake” or “evil twin” access point** that mimics a legitimate one.

> In short:
> We have encryption **after** connection, but no secure method to verify the network **before** connecting.

## 💡 3. Possible directions for a _new solution idea_

Here are several promising research directions that are **simple yet original enough** for your paper.  
You could pick one (or mix two) as your central contribution.

---

### 🧠 Idea 1 — **Wi-Fi Certificate Transparency (like HTTPS for networks)**

#### Concept

Each legitimate Wi-Fi provider (like Starbucks, CNAM, etc.) could register its SSID and BSSID pair in a **public “certificate transparency” log**.  
When a device connects to “Starbucks_WiFi,” it queries the log over cellular or cached data to verify:

> “Is this SSID–BSSID pair signed by a trusted issuer?”

If not, it warns the user or blocks the connection.

#### Why it’s novel

- Borrowing a concept from HTTPS certificate transparency.
    
- No new hardware needed — it’s a **software-layer trust system**.
    
- Can work incrementally (e.g., trusted venues register voluntarily).
    

#### Challenges to discuss

- Log synchronization and availability.
    
- How to prevent privacy leaks from lookups.
    

---

### 🧠 Idea 2 — **Crowdsourced Wi-Fi Legitimacy Verification**

#### Concept

When users connect to Wi-Fi, their devices anonymously share metadata (SSID, BSSID, GPS location) to a shared reputation database.  
Devices cross-check new networks with this data — if many users nearby reported the same SSID–BSSID pair, it’s likely legitimate.  
If not, the device warns the user:

> “No other users have connected to this hotspot here before — possible rogue AP.”

#### Why it’s novel

- Uses a **social-trust or reputation-based system** rather than certificates.
    
- Lightweight, privacy-friendly if designed well (aggregate data).
    
- Works even for small public networks with no formal registration.
    

---

### 🧠 Idea 3 — **Signal Fingerprinting + Behavioral Trust**

#### Concept

Instead of relying only on SSID/BSSID, a device could build a **fingerprint** of trusted APs:

- Signal strength variation over time (RSSI pattern).
    
- Beacon interval and timing jitter.
    
- Channel usage patterns.
    

A fake AP rarely reproduces these physical characteristics exactly.

#### Why it’s novel

- Low-cost: only requires local analysis.
    
- Could use machine learning or threshold matching to classify known vs. new signals.
    

#### Limitation

- False positives if the real AP’s environment changes (e.g., moved, replaced).
    

---

### 🧠 Idea 4 — **Multi-Factor Wi-Fi Authentication (Beyond Passwords)**

#### Concept

Add a second factor for networks that support it — for example:

- A QR code displayed at the venue that devices must scan to verify the AP’s identity.
    
- Or, a short challenge message signed by a backend server, verified by the device.
    

#### Why it’s novel

- Combines physical-world verification (you see the code at the café) with network authentication.
    
- Makes attacks impractical without physical access.
    

---

## ✍️ 4. Recommended direction for your paper

Given that your goal is an **8-page report** (not a PhD thesis), the best balance between simplicity and originality would be:

> **Crowdsourced Wi-Fi Legitimacy Verification System**

It’s easy to explain, fits well into the “open problem” category, and allows you to:

- Describe the **attack** and its **current limits** clearly.
    
- Introduce your idea of a **reputation-based verification protocol**.
    
- Discuss **how it works, what data it needs, how privacy is preserved**, and **potential drawbacks**.
    

You can call your proposal something like **“WiGuard: A Crowdsourced Trust Framework for Detecting Fake Wi-Fi Access Points.”**

--- 

# Papers
- [Convolutional neural network based evil twin attack detection in WiFi networks](https://www.matec-conferences.org/articles/matecconf/abs/2021/05/matecconf_cscns20_08006/matecconf_cscns20_08006.html)
- [EvilScout: Detection and Mitigation of Evil Twin Attack in SDN Enabled WiFi](https://ieeexplore.ieee.org/abstract/document/8989802) 
- 