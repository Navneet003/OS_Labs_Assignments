#!/bin/bash
echo "Enter a number:"
read n 
sum=0
for ((i=1; i<=n; i++)); do 
    sum=$((sum + i*i))
done
echo "Sum of series: $sum"