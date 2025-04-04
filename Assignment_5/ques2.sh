#!/bin/bash

# Function to perform SJF Non-Preemptive Scheduling
sjf_non_preemptive() {
    echo -n "Enter the number of processes: "
    read n

    # Arrays to store process details
    declare -a at bt ct wt tat completed pid gantt gantt_ct

    for ((i=0; i<n; i++)); do
        echo "Process $((i+1)):"
        echo -n "Arrival Time: "
        read at[$i]
        echo -n "Burst Time: "
        read bt[$i]
        pid[$i]=$((i+1))  # Assign process ID
        completed[$i]=0    # Mark as not completed
    done

    time=0  # Current time
    completed_count=0
    total_wt=0
    total_tat=0

    # SJF Non-Preemptive Scheduling
    while [ $completed_count -lt $n ]; do
        # Find process with shortest burst time that has arrived
        min_bt=9999
        min_index=-1

        for ((i=0; i<n; i++)); do
            if [ ${completed[$i]} -eq 0 ] && [ ${at[$i]} -le $time ] && [ ${bt[$i]} -lt $min_bt ]; then
                min_bt=${bt[$i]}
                min_index=$i
            fi
        done

        if [ $min_index -ne -1 ]; then
            # Calculate completion, turnaround, and waiting times
            time=$((time + bt[$min_index]))
            ct[$min_index]=$time
            tat[$min_index]=$((ct[$min_index] - at[$min_index]))
            wt[$min_index]=$((tat[$min_index] - bt[$min_index]))
            total_wt=$((total_wt + wt[$min_index]))
            total_tat=$((total_tat + tat[$min_index]))

            # Mark process as completed
            completed[$min_index]=1
            gantt[$completed_count]=${pid[$min_index]}  # Store process ID for Gantt chart
            gantt_ct[$completed_count]=${ct[$min_index]}  # Store completion time for Gantt chart
            completed_count=$((completed_count + 1))
        else
            time=$((time + 1))  # Increment time if no process is ready
        fi
    done

    # Calculate averages
    avg_wt=$(echo "scale=2; $total_wt / $n" | bc)
    avg_tat=$(echo "scale=2; $total_tat / $n" | bc)

    # Print the results
    echo -e "\nProcess\tAT\tBT\tCT\tWT\tTAT"
    for ((i=0; i<n; i++)); do
        echo -e "P${pid[$i]}\t${at[$i]}\t${bt[$i]}\t${ct[$i]}\t${wt[$i]}\t${tat[$i]}"
    done
    echo -e "\nAverage Waiting Time: $avg_wt"
    echo -e "Average Turnaround Time: $avg_tat"

    # Gantt Chart
    echo -e "\nGantt Chart:"

    # Print the Gantt Chart process bar
    echo -n "|"
    for ((i=0; i<completed_count; i++)); do
        printf " P%-2s |" "${gantt[$i]}"
    done
    echo

    # Print the Gantt Chart time axis (aligned properly)
    printf "%-4s" "0"  # Start from time 0
    for ((i=0; i<completed_count; i++)); do
        printf "%-6s" "${gantt_ct[$i]}"
    done
    echo -e "\n"
}

# Run the SJF Non-Preemptive Scheduling
sjf_non_preemptive
