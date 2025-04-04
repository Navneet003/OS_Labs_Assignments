#!/bin/bash

# ===================================
# Q2: Bounded Buffer Problem (Bash Sim)
# Author: Sugam Arora
# Description: Simulates fixed-size buffer for producer-consumer using arrays.
# ===================================

BUFFER_SIZE=5
BUFFER=()

# Colors
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
NC="\033[0m"

produce() {
    while true; do
        if [ "${#BUFFER[@]}" -lt "$BUFFER_SIZE" ]; then
            item=$((RANDOM % 1000))
            BUFFER+=("$item")
            echo -e "${YELLOW}[Producer] $(date +"%T") - Produced: $item | Buffer Size: ${#BUFFER[@]}${NC}"
        fi
        sleep 1
    done
}

consume() {
    while true; do
        if [ "${#BUFFER[@]}" -gt 0 ]; then
            item="${BUFFER[0]}"
            BUFFER=("${BUFFER[@]:1}")
            echo -e "${BLUE}[Consumer] $(date +"%T") - Consumed: $item | Buffer Size: ${#BUFFER[@]}${NC}"
        fi
        sleep 2
    done
}

# Run in background
produce &
consume &

# Wait forever
wait