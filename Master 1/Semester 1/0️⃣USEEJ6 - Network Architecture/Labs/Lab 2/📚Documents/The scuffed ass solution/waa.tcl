$ns duplex-link $n0 $n1 10Mb 40ms DropTail

# Connect TCP source to TCP sink (end-to-end flow)
$ns connect $tcp0 $tcp1

# Schedule: start FTP at 0.0s, stop at 0.7s
$ns at 0.0 {$ftp start}
$ns at 3.0 {$ftp stop}

# Start periodic cwnd tracing at 0.0s
$ns at 0.0 {tracewindow}

# Finish simulation at 1.0s (flush+exit)
$ns at 3.1 {finish}


