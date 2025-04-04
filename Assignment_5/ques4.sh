#!/bin/bash

# Function to perform Non-Preemptive Priority Scheduling
priority_scheduling() {
    echo -n "Enter the number of processes: "
    read n

    # Arrays to store process details
    declare -a at bt priority ct wt tat pid gantt gantt_time executed_process completed

    for ((i=0; i<n; i++)); do
        echo "Process $((i+1)):"
        echo -n "Arrival Time: "
        read at[$i]
        echo -n "Burst Time: "
        read bt[$i]
        echo -n "Priority (lower number = higher priority): "
        read priority[$i]
        pid[$i]=$((i+1))  # Assign process ID
        completed[$i]=0   # Mark process as not completed
    done

    # Initialize variables
    time=0
    total_wt=0
    total_tat=0
    completed_count=0

    while [ $completed_count -lt $n ]; do
        highest_priority=-1
        selected=-1

        for ((i=0; i<n; i++)); do
            if [[ ${completed[$i]} -eq 0 && ${at[$i]} -le $time ]]; then
                if [[ $highest_priority -eq -1 || ${priority[$i]} -lt $highest_priority ]]; then
                    highest_priority=${priority[$i]}
                    selected=$i
                fi
            fi
        done

        if [[ $selected -eq -1 ]]; then
            time=$((time + 1))  # CPU remains idle
            continue
        fi

        # Execute the selected process
        gantt+=(${pid[$selected]})
        gantt_time+=($time)
        executed_process+=(${pid[$selected]})

        ct[$selected]=$((time + bt[$selected]))  # Completion time
        tat[$selected]=$((ct[$selected] - at[$selected]))  # Turnaround Time
        wt[$selected]=$((tat[$selected] - bt[$selected]))  # Waiting Time
        total_wt=$((total_wt + wt[$selected]))
        total_tat=$((total_tat + tat[$selected]))

        time=${ct[$selected]}  # Move time forward
        completed[$selected]=1  # Mark as completed
        completed_count=$((completed_count + 1))
    done

    gantt_time+=($time)  # Add last execution time in Gantt chart

    # Calculate averages
    avg_wt=$(echo "scale=2; $total_wt / $n" | bc)
    avg_tat=$(echo "scale=2; $total_tat / $n" | bc)

    # Print the results
    echo -e "\nProcess\tAT\tBT\tPr\tCT\tWT\tTAT"
    for ((i=0; i<n; i++)); do
        echo -e "P${pid[$i]}\t${at[$i]}\t${bt[$i]}\t${priority[$i]}\t${ct[$i]}\t${wt[$i]}\t${tat[$i]}"
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

# Run the Non-Preemptive Priority Scheduling
priority_scheduling
