#!/bin/bash

read -p "Enter the directory path: " dir
read -p "Enter the file extension (e.g., txt, sh, log): " ext

# Check if directory exists
if [ ! -d "$dir" ]; then
    echo "Error: Directory '$dir' not found."
    exit 1
fi

# Count files with the given extension
count=$(find "$dir" -type f -name "*.$ext" | wc -l)

echo "Number of '.$ext' files in '$dir': $count"
