#!/bin/bash

# Function to perform SJF Preemptive (Shortest Remaining Time First - SRTF) Scheduling
sjf_preemptive() {
    echo -n "Enter the number of processes: "
    read n

    # Arrays to store process details
    declare -a at bt remaining_time ct wt tat pid gantt gantt_time executed_process

    for ((i=0; i<n; i++)); do
        echo "Process $((i+1)):"
        echo -n "Arrival Time: "
        read at[$i]
        echo -n "Burst Time: "
        read bt[$i]
        pid[$i]=$((i+1))  # Assign process ID
        remaining_time[$i]=${bt[$i]}  # Initially, remaining time = burst time
    done

    time=0  # Current time
    completed=0
    total_wt=0
    total_tat=0
    prev_process=-1  # Track previous process to record Gantt Chart changes

    # SJF Preemptive Scheduling (SRTF)
    while [ $completed -lt $n ]; do
        # Find the process with the shortest remaining time that has arrived
        min_rt=9999
        min_index=-1

        for ((i=0; i<n; i++)); do
            if [ ${remaining_time[$i]} -gt 0 ] && [ ${at[$i]} -le $time ] && [ ${remaining_time[$i]} -lt $min_rt ]; then
                min_rt=${remaining_time[$i]}
                min_index=$i
            fi
        done

        if [ $min_index -ne -1 ]; then
            # Execute the selected process for 1 time unit
            remaining_time[$min_index]=$((remaining_time[$min_index] - 1))
            gantt[$time]=${pid[$min_index]}  # Store process ID in Gantt chart
            
            # If a new process starts execution, mark the time
            if [ ${pid[$min_index]} -ne $prev_process ]; then
                gantt_time+=($time)
                executed_process+=(${pid[$min_index]})
            fi
            prev_process=${pid[$min_index]}

            # If process completes
            if [ ${remaining_time[$min_index]} -eq 0 ]; then
                completed=$((completed + 1))
                ct[$min_index]=$((time + 1))  # Completion time
                tat[$min_index]=$((ct[$min_index] - at[$min_index]))  # Turnaround Time
                wt[$min_index]=$((tat[$min_index] - bt[$min_index]))  # Waiting Time
                total_wt=$((total_wt + wt[$min_index]))
                total_tat=$((total_tat + tat[$min_index]))
            fi
        fi
        time=$((time + 1))
    done

    # Add the last execution time in Gantt chart
    gantt_time+=($time)

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
    for ((i=0; i<${#executed_process[@]}; i++)); do
        printf " P%-2s |" "${executed_process[$i]}"
    done
    echo

    # Print the Gantt Chart time axis (aligned properly)
    printf "%-4s" "${gantt_time[0]}"
    for ((i=1; i<${#gantt_time[@]}; i++)); do
        printf "%-6s" "${gantt_time[$i]}"
    done
    echo -e "\n"
}

# Run the SJF Preemptive Scheduling
sjf_preemptive
