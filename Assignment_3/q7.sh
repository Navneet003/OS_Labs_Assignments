#!/bin/bash

read -p "Enter the input file name: " input_file
read -p "Enter the output file name: " output_file

if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found."
    exit 1
fi

# Sort the numbers and save to output file
sort -n "$input_file" > "$output_file"

echo "Sorted numbers saved to '$output_file'."
