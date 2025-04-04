#!/bin/bash

echo "Enter the filename to monitor:"
read file_to_monitor
echo "Monitoring file: $file_to_monitor"

fswatch -o "$file_to_monitor" | while read num; do
    echo "$(date +"%Y-%m-%d %H:%M:%S") $file_to_monitor was modified"
done