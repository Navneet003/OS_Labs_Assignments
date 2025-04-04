#!/bin/bash

QUEUE_FILE="shared_queue.txt"
> "$QUEUE_FILE"  # Clear previous data

# Ask user for queue size
read -p "Enter the maximum queue size: " QUEUE_SIZE

# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"  # No color

# Producer Function
producer() {
    while true; do
        local size
        size=$(wc -l < "$QUEUE_FILE")
        if [ "$size" -lt "$QUEUE_SIZE" ]; then
            local value=$((RANDOM % 100))
            echo "$value" >> "$QUEUE_FILE"
            echo -e "${GREEN}[Producer] $(date +"%T") - Enqueued: $value${NC}"
        fi
        sleep 1
    done
}

# Consumer Function
consumer() {
    while true; do
        if [ -s "$QUEUE_FILE" ]; then
            local value
            value=$(head -n 1 "$QUEUE_FILE")
            sed -i.bak '1d' "$QUEUE_FILE" && rm -f "${QUEUE_FILE}.bak"
            echo -e "${RED}[Consumer] $(date +"%T") - Dequeued: $value${NC}"
        fi
        sleep 2
    done
}

# Start producer and consumer as background processes
producer &
consumer &

# Keep script running
wait
