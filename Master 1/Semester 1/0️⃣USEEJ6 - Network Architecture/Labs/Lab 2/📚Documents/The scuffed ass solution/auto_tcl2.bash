#!/bin/bash

# run_simulations.sh
# Automated batch runner for NS-2 TCP lab Exercise 2
# Writes results to three separate CSV files for easy plotting.

TCL_SCRIPT="ex2.tcl"
OUT1="scenario1.csv"
OUT2="scenario2.csv"
OUT3="scenario3.csv"

# Clear previous results and write CSV headers
echo "cwnd_pkts;bw_Mb;delay_ms;throughput_Mbps" > "$OUT1"
echo "cwnd_pkts;bw_Mb;delay_ms;throughput_Mbps" > "$OUT2"
echo "cwnd_pkts;bw_Mb;delay_ms;throughput_Mbps" > "$OUT3"

# Function to run the simulation and calculate throughput
run_and_analyze() {
    local CWND=$1
    local BW=$2
    local DELAY=$3
    local OUTPUT_FILE=$4
    
    echo -n "  CWND=$CWND, BW=${BW}Mb, Delay=${DELAY}ms... "

    # 1. Run the NS-2 simulation (redirect all output to suppress noise)
    # The TCL script usage is: ns ex2.tcl <cwnd_pkts> <bandwidth_Mb> <delay_ms>
    ns $TCL_SCRIPT $CWND $BW $DELAY > /dev/null 2>&1

    # 2. Analyze the trace file using the external AWK script
    # The AWK script reads trace.csv and prints the throughput to stdout
    # The -f flag specifies the AWK script file.
    THROUGHPUT_Mbps=$(awk -f analyze_throughput.awk trace.csv)
    
    # 3. Handle potential errors (e.g., if AWK returned 0.0 or failed)
    if [[ -z "$THROUGHPUT_Mbps" || "$THROUGHPUT_Mbps" == "0.0" ]]; then
        echo "FAILED (Analysis error or 0.0 Mbps)"
        THROUGHPUT_Mbps="ERROR"
    else
        echo "done (throughput=${THROUGHPUT_Mbps} Mbps)"
    fi
    
    # 4. Append results to the specified CSV file
    echo "$CWND;$BW;$DELAY;$THROUGHPUT_Mbps" >> "$OUTPUT_FILE"
}

# -----------------------------
# SCENARIO 1: Vary cwnd
# Fixed: bw=10 Mb, delay=40 ms
# -----------------------------
echo -e "\n--- Running Scenario 1: varying congestion window ---"
for cwnd in 1 5 10 15 20 25 30; do
    run_and_analyze "$cwnd" 10 40 "$OUT1"
done

# -----------------------------
# SCENARIO 2: Vary delay
# Fixed: bw=10 Mb, cwnd=30
# -----------------------------
echo -e "\n--- Running Scenario 2: varying propagation delay ---"
for delay in 2.5 5 10 15 30 40; do
    run_and_analyze 30 10 "$delay" "$OUT2"
done

# -----------------------------
# SCENARIO 3: Vary bandwidth
# Fixed: cwnd=30, delay=40 ms
# -----------------------------
echo -e "\n--- Running Scenario 3: varying bandwidth ---"
for bw in 1 5 10 15 20 25 30; do
    run_and_analyze 30 "$bw" 40 "$OUT3"
done

echo -e "\n✅ All scenarios completed!"
echo "Results saved to: $OUT1, $OUT2, $OUT3"
