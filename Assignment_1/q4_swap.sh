
# swap two integers
echo "Enter the first integer:"
read num1
echo "Enter the second integer:"
read num2

# Display the original values
echo "Before swapping: num1 = $num1, num2 = $num2"

# Swap the numbers using a temporary variable
temp=$num1
num1=$num2
num2=$temp

# Display after swapping
echo "After swapping: num1 = $num1, num2 = $num2"