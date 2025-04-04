#!/bin/bash
echo "Choose the type of series sum you want to calculate:"
echo "1. Sum of squares of numbers up to N (1² + 2² + 3² + ... + N²)"
echo "2. Sum of cubes of numbers up to N (1³ + 2³ + 3³ + ... + N³)"
echo "Enter your choice (1/2):"
read choice

echo "Enter the value of N:"
read N

sum=0

case $choice in
    1)
        for (( i=1; i<=N; i++ )); do 
            sum=$((sum + i*i))
        done
        echo "The sum of squares of numbers up to $N is: $sum"
        ;;
    2)
        for (( i=1; i<=N; i++ )); do 
            sum=$((sum + i*i*i))
        done
        echo "The sum of cubes of numbers up to $N is: $sum"
        ;;
    *)
        echo "Invalid choice! Please select a valid option."
        ;;
esac
