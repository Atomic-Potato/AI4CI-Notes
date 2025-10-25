if {[llength $argv] < 3} {
    puts stderr "Usage: ns ex2.tcl <cwnd_pkts> <bandwidth_Mb> <delay_ms>"
    exit 1
}

set cwnd_pkts [lindex $argv 0]
set bandwidth_Mb [lindex $argv 1]
set delay_ms [lindex $argv 2]

# Create simulator instance
set ns [new Simulator]

# Open trace files: text trace and NAM animation
set ftrace [open trace.tr w]
set csv [open trace.csv w]
set nf [open out.nam w]
$ns namtrace-all $nf

# Cleanup + exit at the end of the run
proc finish {} {
    global ns ftrace nf csv
    $ns flush-trace         ;# flush buffers to files
    close $nf               ;# close NAM file
    close $ftrace           ;# close text trace
    close $csv
    exit 0                  ;# terminate the simulation
}

# Record TCP cwnd to the trace file
proc tracewindow {} {
    global tcp0 ftrace csv
    set ns [Simulator instance]
    if {![info exists tcp0]} { return }   ;# if TCP not set, stop
    set time 0.001                         ;
    set now [$ns now]                      ;# current sim time
    set now [format "%.3f" $now]           ;# format time (ms precision)
    set cwnd [$tcp0 set cwnd_]             ;# read TCP congestion window
    set seqno [$tcp0 set seqno_]
    set ackno [$tcp0 set ack_]
    puts $ftrace "$now $cwnd $seqno $ackno"              ;# write "time cwnd" to trace
	puts $csv "$now;$cwnd;$seqno;$ackno"              ;# write "time cwnd" to trace
    $ns at [expr $now+$time] {tracewindow} ;# reschedule next sample
}

# Set TCP defaults: packet size and max cwnd (pkts)
Agent/TCP set packetSize_ 1500
Agent/TCP set maxcwnd_ $cwnd_pkts

# Create sender node and attach a TCP agent
set n0 [$ns node]
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

# Attach an FTP application over the TCP agent
set ftp [new Application/FTP]
$ftp attach-agent $tcp0

# Create receiver node and attach a TCP sink
set n1 [$ns node]
set tcp1 [new Agent/TCPSink]
$ns attach-agent $n1 $tcp1

# Connect the two nodes with a duplex point-to-point link
# Link: 10 Mb bandwidth, 10 ms delay, DropTail queue

$ns duplex-link $n0 $n1 ${bandwidth_Mb}Mb ${delay_ms}ms DropTail

# Connect TCP source to TCP sink (end-to-end flow)
$ns connect $tcp0 $tcp1

# Schedule: start FTP at 0.0s, stop at 0.7s
$ns at 0.0 {$ftp start}
$ns at 3.0 {$ftp stop}

# Start periodic cwnd tracing at 0.0s
$ns at 0.0 {tracewindow}

# Finish simulation at 1.0s (flush+exit)
$ns at 3.1 {finish}

# Run the simulation
$ns run


