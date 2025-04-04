#!/bin/bash
echo "Enter a number:"
read n
echo "Odd numbers up to $n:" 
for ((i=1; i<=n; i+=2)); do
    echo $i
done