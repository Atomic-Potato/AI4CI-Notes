[# ---------- 1. Simulator Setup ----------
set ns [new Simulator]

# Open output files
set ftrace [open ex4.csv w]
set nf [open ex4.nam w]
$ns namtrace-all $nf

# Define finish procedure
proc finish {} {
    global ns ftrace nf
    $ns flush-trace
    close $nf
    close $ftrace
    exit 0
}

# ---------- 2. Tracing Procedure ----------
# This procedure will trace cwnd and ssthresh
proc tracewindow {} {
    global tcp0 ftrace
    set ns [Simulator instance]
    if {! [info exists tcp0]} { return }
    set time 0.01 ;# Polling interval
    set now [$ns now]
    set now [format "%.3f" $now]
    
    # Get the sender's congestion window and slow-start threshold
    set cwnd [$tcp0 set cwnd_]
    set ssthresh [$tcp0 set ssthresh_]
    
    # Write time;cwnd;ssthresh to the CSV file
    puts $ftrace "$now;$cwnd;$ssthresh"
    
    # Reschedule
    $ns at [expr $now+$time] {tracewindow}
}

# ---------- 3. Define Nodes (A, R, B) ----------
set A [$ns node]
set R [$ns node]
set B [$ns node]

# ---------- 4. Define Links ----------
# Link A -> R: 155 MB/s (1240 Mb/s), 1ms delay
$ns duplex-link $A $R 1240Mb 1ms DropTail

# Link R -> B: 0.07 MB/s (0.56 Mb/s), 4ms delay (This is the bottleneck)
$ns duplex-link $R $B 0.56Mb 4ms DropTail

# --- Set Router (R) Queue Limit ---
# This is a key requirement [cite: 1868]
$ns queue-limit $R $B 20

# ---------- 5. TCP Setup ----------
# Set global packet size
Agent/TCP set packetSize_ 1500

# Create TCP sender (Agent) on Node A
set tcp0 [new Agent/TCP]
$ns attach-agent $A $tcp0

# --- Configure TCP Parameters ---
# Set max window and ssthresh as required [cite: 1867]
$tcp0 set maxcwnd_ 64
$tcp0 set ssthresh_ 64

# Create TCP receiver (Sink) on Node B
set sink0 [new Agent/TCPSink]
$ns attach-agent $B $sink0

# Connect the sender and sink
$ns connect $tcp0 $sink0

# ---------- 6. Application Setup ----------
# FTP application will send as much data as possible
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

# ---------- 7. Scheduling ----------
# Start FTP and tracing at 0.0s
$ns at 0.0 {$ftp0 start}
$ns at 0.0 {tracewindow}

# Run for 30 seconds to observe multiple congestion events
$ns at 30.0 {$ftp0 stop}
$ns at 30.1 {finish}

# ---------- 8. Run Simulation ----------
$ns run]

