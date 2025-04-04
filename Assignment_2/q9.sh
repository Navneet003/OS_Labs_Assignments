#!/bin/bash
echo "Enter the name of the file (with extension):"
read file

if [! -f "$file" ]; then 
    echo "File not found!" 
    exit 1
fi

echo "Choose the type of pattern search you want to perform:" 
echo "1. Search for a specific word" 
echo "2. Search for a word (case insensitive)" 
echo "3. Count occurrences of a word" 
echo "4. Search for a pattern with regular expression" 
echo "5. Display lines containing a specific word" 
echo "6. Search and display lines without a specific word"
read choice 

case $choice in
    1)
        echo "Enter the word to search for:" 
        read word
        grep -w "$word" "$file"
        ;;
    2)
        echo "Enter the word to search for (case insensitive):" 
        read word
        grep -iw "$word" "$file"
        ;;
    3)
        echo "Enter the word to count occurrences of:" 
        read word
        count=$(grep -o -w "$word" "$file" | wc -l) 
        echo "The word '$word' appears $count times."
        ;;
    4)
        echo "Enter the regular expression to search for:" 
        read regex
        grep -E "$regex" "$file"
        ;;
    5)
        echo "Enter the word to display lines containing it:" 
        read word
        grep -w "$word" "$file"
        ;;
    6)
        echo "Enter the word to search and display lines without it:" 
        read word
        grep -vw "$word" "$file"
        ;;
    *)
        echo "Invalid choice. Please select a valid option."
        ;;
esac
