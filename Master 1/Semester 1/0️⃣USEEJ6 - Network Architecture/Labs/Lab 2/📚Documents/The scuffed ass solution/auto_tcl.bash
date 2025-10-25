#!/bin/bash

# run_ex2_scenarios.sh
# Automated batch runner for NS-2 TCP lab Exercise 2
# Requires: ns-2 installed and 'ex2.tcl' in the same directory

# Output files
OUT1="scenario1.csv"
OUT2="scenario2.csv"
OUT3="scenario3.csv"

# Clear previous results
> "$OUT1"
> "$OUT2"
> "$OUT3"

# Write CSV headers
echo "cwnd_pkts;bw_Mb;delay_ms;throughput_Mbps" > "$OUT1"
echo "cwnd_pkts;bw_Mb;delay_ms;throughput_Mbps" > "$OUT2"
echo "cwnd_pkts;bw_Mb;delay_ms;throughput_Mbps" > "$OUT3"

# -----------------------------
# SCENARIO 1: Vary cwnd
# Fixed: bw=10 Mb, delay=40 ms
# -----------------------------
echo "Running Scenario 1: varying congestion window..."
for cwnd in 1 5 10 15 20 25 30; do
    echo -n "  cwnd=$cwnd... "
    result=$(ns ex2.tcl "$cwnd" 10 40 2>/dev/null | grep "^RESULT;")
    if [[ -n "$result" ]]; then
        # Extract throughput value
        thr=$(echo "$result" | cut -d';' -f5 | cut -d'=' -f2)
        echo "$cwnd;10;40;$thr" >> "$OUT1"
        echo "done (throughput=${thr} Mbps)"
    else
        echo "FAILED"
        echo "$cwnd;10;40;ERROR" >> "$OUT1"
    fi
done

# -----------------------------
# SCENARIO 2: Vary delay
# Fixed: bw=10 Mb, cwnd=30
# -----------------------------
echo -e "\nRunning Scenario 2: varying propagation delay..."
for delay in 2.5 5 10 15 30 40; do
    echo -n "  delay=${delay}ms... "
    result=$(ns ex2.tcl 30 10 "$delay" 2>/dev/null | grep "^RESULT;")
    if [[ -n "$result" ]]; then
        thr=$(echo "$result" | cut -d';' -f5 | cut -d'=' -f2)
        echo "30;10;$delay;$thr" >> "$OUT2"
        echo "done (throughput=${thr} Mbps)"
    else
        echo "FAILED"
        echo "30;10;$delay;ERROR" >> "$OUT2"
    fi
done

# -----------------------------
# SCENARIO 3: Vary bandwidth
# Fixed: cwnd=30, delay=40 ms
# -----------------------------
echo -e "\nRunning Scenario 3: varying bandwidth..."
for bw in 1 5 10 15 20 25 30; do
    echo -n "  bw=${bw}Mb... "
    result=$(ns ex2.tcl 30 "$bw" 40 2>/dev/null | grep "^RESULT;")
    if [[ -n "$result" ]]; then
        thr=$(echo "$result" | cut -d';' -f5 | cut -d'=' -f2)
        echo "30;$bw;40;$thr" >> "$OUT3"
        echo "done (throughput=${thr} Mbps)"
    else
        echo "FAILED"
        echo "30;$bw;40;ERROR" >> "$OUT3"
    fi
done

echo -e "\n✅ All scenarios completed!"
echo "Results saved to:"
echo "  $OUT1"
echo "  $OUT2"
echo "  $OUT3"

