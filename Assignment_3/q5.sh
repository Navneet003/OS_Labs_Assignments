echo "Enter a string or number to check palindrome:"
read input
rev=$(echo "$input" | rev)
if [ "$input" == "$rev" ]; then
    echo "'$input' is a palindrome."
else
    echo "'$input' is not a palindrome."
fi