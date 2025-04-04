#!/bin/bash

# Function for Round Robin Scheduling
round_robin() {
    echo -n "Enter the number of processes: "
    read n

    # Arrays to store process data
    declare -a at bt ct wt tat remaining_bt pid gantt gantt_time executed_process

    for ((i=0; i<n; i++)); do
        echo "Process $((i+1)):"
        echo -n "Arrival Time: "
        read at[$i]
        echo -n "Burst Time: "
        read bt[$i]
        pid[$i]=$((i+1))  # Assign process ID
        remaining_bt[$i]=${bt[$i]}  # Initialize remaining burst time
    done

    echo -n "Enter Time Quantum: "
    read tq

    # Initialize variables
    time=0
    total_wt=0
    total_tat=0
    queue=()
    completed_count=0
    in_queue=()

    # Function to check if process is in queue
    is_in_queue() {
        local search=$1
        for p in "${queue[@]}"; do
            if [[ $p -eq $search ]]; then
                return 0  # Found
            fi
        done
        return 1  # Not found
    }

    # Add processes that arrive at time = 0
    for ((i=0; i<n; i++)); do
        in_queue[$i]=0  # Initialize queue tracking
    done
    for ((i=0; i<n; i++)); do
        if [[ ${at[$i]} -eq 0 ]]; then
            queue+=($i)
            in_queue[$i]=1
        fi
    done

    gantt_time+=($time)

    # Round Robin Execution Loop
    while [[ $completed_count -lt $n ]]; do
        if [[ ${#queue[@]} -eq 0 ]]; then
            # If no process is available, move time forward
            time=$((time + 1))
            gantt+=("IDLE")
            gantt_time+=($time)

            # Check for new arrivals
            for ((i=0; i<n; i++)); do
                if [[ ${at[$i]} -eq $time && ${remaining_bt[$i]} -gt 0 ]]; then
                    queue+=($i)
                    in_queue[$i]=1
                fi
            done
            continue
        fi

        index=${queue[0]}
        queue=("${queue[@]:1}")  # Remove first element

        gantt+=("P${pid[$index]}")
        executed_process+=(${pid[$index]})

        if [[ ${remaining_bt[$index]} -le $tq ]]; then
            time=$((time + remaining_bt[$index]))
            remaining_bt[$index]=0
            ct[$index]=$time
            tat[$index]=$((ct[$index] - at[$index]))
            wt[$index]=$((tat[$index] - bt[$index]))
            total_wt=$((total_wt + wt[$index]))
            total_tat=$((total_tat + tat[$index]))
            completed_count=$((completed_count + 1))
        else
            time=$((time + tq))
            remaining_bt[$index]=$((remaining_bt[$index] - tq))
        fi

        gantt_time+=($time)

        # Add new arrivals
        for ((i=0; i<n; i++)); do
            if [[ ${at[$i]} -le $time && ${remaining_bt[$i]} -gt 0 && ${in_queue[$i]} -eq 0 ]]; then
                queue+=($i)
                in_queue[$i]=1
            fi
        done

        # Reinsert process at the end if it still needs execution
        if [[ ${remaining_bt[$index]} -gt 0 ]]; then
            queue+=($index)
        fi
    done

    # Calculate averages
    avg_wt=$(echo "scale=2; $total_wt / $n" | bc)
    avg_tat=$(echo "scale=2; $total_tat / $n" | bc)

    # Print Process Table
    echo -e "\nProcess\tAT\tBT\tCT\tWT\tTAT"
    for ((i=0; i<n; i++)); do
        echo -e "P${pid[$i]}\t${at[$i]}\t${bt[$i]}\t${ct[$i]}\t${wt[$i]}\t${tat[$i]}"
    done
    echo -e "\nAverage Waiting Time: $avg_wt"
    echo -e "Average Turnaround Time: $avg_tat"

    # Print Gantt Chart
    echo -e "\nGantt Chart:"
    echo -n "|"
    for ((i=0; i<${#gantt[@]}; i++)); do
        printf " %-5s |" "${gantt[$i]}"
    done
    echo

    # Print the Gantt Chart time axis
    printf "%-5s" "${gantt_time[0]}"
    for ((i=1; i<${#gantt_time[@]}; i++)); do
        printf "%-7s" "${gantt_time[$i]}"
    done
    echo -e "\n"
}

# Run the Round Robin Scheduling function
round_robin
