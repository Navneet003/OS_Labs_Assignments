# Sum of digits

echo "Enter a number:"
read number

sum=0

while [ $number -gt 0 ]; do
    # Extract the last digit
    digit=$((number % 10))
    # Add the digit to the sum
    sum=$((sum + digit))
    # Remove the last digit34
    number=$((number / 10))
done

# Display the result
echo "The sum of digits is: $sum"


