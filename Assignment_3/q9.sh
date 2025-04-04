#!/bin/bash

echo "System Information"
echo "------------------"

echo "OS Version: $(uname -s) $(uname -r)"

echo "Kernel Version: $(uname -v)"

echo "System Uptime: $(uptime -p)"

echo "CPU Info: $(sysctl -n machdep.cpu.brand_string 2>/dev/null || lscpu | grep 'Model name')"

echo "Total RAM: $(vm_stat | awk '/Pages free/ {print $3 * 4096 / 1024 / 1024 " MB"}' 2>/dev/null || free -h | grep Mem | awk '{print $2}')"


