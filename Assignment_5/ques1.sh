#!/bin/bash

# Function to perform FCFS Scheduling
fcfs_scheduling() {
    echo -n "Enter the number of processes: "
    read n

    # Arrays to store process details
    declare -a at bt ct wt tat

    for ((i=0; i<n; i++)); do
        echo "Process $((i+1)):"
        echo -n "Arrival Time: "
        read at[$i]
        echo -n "Burst Time: "
        read bt[$i]
    done

    # Sort processes by arrival time
    for ((i=0; i<n-1; i++)); do
        for ((j=0; j<n-i-1; j++)); do
            if [ ${at[$j]} -gt ${at[$((j+1))]} ]; then
                # Swap arrival time
                temp=${at[$j]}
                at[$j]=${at[$((j+1))]}
                at[$((j+1))]=$temp

                # Swap burst time
                temp=${bt[$j]}
                bt[$j]=${bt[$((j+1))]}
                bt[$((j+1))]=$temp
            fi
        done
    done

    # Calculate Completion Time, Turnaround Time, and Waiting Time
    ct[0]=$((at[0] + bt[0]))
    tat[0]=$((ct[0] - at[0]))
    wt[0]=$((tat[0] - bt[0]))

    total_wt=${wt[0]}
    total_tat=${tat[0]}

    for ((i=1; i<n; i++)); do
        if [ ${ct[$((i-1))]} -lt ${at[$i]} ]; then
            ct[$i]=$((at[$i] + bt[$i]))
        else
            ct[$i]=$((ct[$((i-1))] + bt[$i]))
        fi
        tat[$i]=$((ct[$i] - at[$i]))
        wt[$i]=$((tat[$i] - bt[$i]))

        total_wt=$((total_wt + wt[$i]))
        total_tat=$((total_tat + tat[$i]))
    done

    avg_wt=$(echo "scale=2; $total_wt / $n" | bc)
    avg_tat=$(echo "scale=2; $total_tat / $n" | bc)

    # Print the results
    echo -e "\nProcess\tAT\tBT\tCT\tWT\tTAT"
    for ((i=0; i<n; i++)); do
        echo -e "P$((i+1))\t${at[$i]}\t${bt[$i]}\t${ct[$i]}\t${wt[$i]}\t${tat[$i]}"
    done
    echo -e "\nAverage Waiting Time: $avg_wt"
    echo -e "Average Turnaround Time: $avg_tat"

    # Gantt Chart
    echo -e "\nGantt Chart:"
    for ((i=0; i<n; i++)); do
        echo -n "| P$((i+1)) "
    done
    echo "|"
    echo -n "0"
    for ((i=0; i<n; i++)); do
        echo -n "    ${ct[$i]}"
    done
    echo -e "\n"
}

# Run the FCFS Scheduling
fcfs_scheduling
