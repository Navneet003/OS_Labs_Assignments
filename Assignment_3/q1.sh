echo "Enter process name to check:"
read process_name
pid=$(pgrep -x "$process_name" )
if [ -n "$pid" ]; then
    echo "Process '$process_name' is running with PID: $pid"
else
    echo "Process '$process_name' is not running."
fi
