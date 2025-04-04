#!/bin/bash
echo "Enter three numbers:"
read a b c 
largest=$a 
smallest=$a
if [$b -gt $largest ]; then 
    largest=$b
fi 
if [ $c -gt $largest ]; then 
    largest=$c
fi 
if [ $b -lt $smallest ]; then 
    smallest=$b
fi
if [ $c -lt $smallest l; then
    smallest=$c
fi
echo "Largest: $largest" 
echo "Smallest: $smallest"