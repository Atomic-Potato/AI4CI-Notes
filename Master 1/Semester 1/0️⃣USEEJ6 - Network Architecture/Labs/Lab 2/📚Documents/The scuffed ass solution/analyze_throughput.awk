#!/usr/bin/awk -f

# AWK script to calculate average throughput from trace.csv

BEGIN {
    FS=";"                     # Set the field separator to semicolon (;)
    PACKET_SIZE = 1500         # Byte size of one packet (from your TCL script)
    # The simulation runs from t=0.0s to t=3.0s, so duration is 3.0s
    SIM_DURATION = 3.0
}

# Process the body of the file (skip the header if one exists)
{
    # Check if the first field is a number (to skip a text header if present)
    if ($1 ~ /^[0-9]/) {
        # The 'ackno' column is the 4th field
        CURRENT_ACK = $4
    }
}

END {
    # If the file was empty or no data was processed
    if (NR <= 1) {
        print "0.0" > "/dev/stderr" # Output 0.0 to standard error for Bash to handle
        exit
    }

    # The last recorded ackno value is the total number of packets acknowledged (Pkts)
    # Assuming $ackno is a packet count (or seqno is a packet count)
    TOTAL_PKTS_ACKED = CURRENT_ACK

    # Total data acknowledged in bits: Pkts * Pkt_Size (Bytes) * 8 (bits/byte)
    TOTAL_BITS = TOTAL_PKTS_ACKED * PACKET_SIZE * 8

    # Average Throughput in bits/second
    THROUGHPUT_bps = TOTAL_BITS / SIM_DURATION

    # Convert to Megabits per second (Mbps). Use 1,000,000 for network engineering.
    THROUGHPUT_Mbps = THROUGHPUT_bps / 1000000.0

    # Print the final result to standard output (where the Bash script will read it)
    printf "%.4f", THROUGHPUT_Mbps
}
