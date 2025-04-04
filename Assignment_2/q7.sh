#!/bin/bash
# Shell script to perform arithmetic operations using switch-case
read -p "Enter the first number: " num1
read -p "Enter the second number: " num2

echo "Choose an operation:" 
echo "1. Addition (+)" 
echo "2. Subtraction (-)" 
echo "3. Multiplication (*)"
echo "4. Division (/)" 
echo "5. Modulus (%)"
read -p "Enter your choice (1-5): " operation

case $operation in
    1)
        result=$((num1 + num2))
        echo "Result: $num1 + $num2 = $result"
        ;;
    2)
        result=$((num1 - num2))
        echo "Result: $num1 - $num2 = $result"
        ;;
    3)
        result=$((num1 * num2))    
        echo "Result: $num1 * $num2 = $result"
        ;;
    4)
        if [ "$num2" -ne 0 ]; then 
            result=$(echo "scale=2; $num1 / $num2" | bc)  
            echo "Result: $num1 / $num2 = $result"
        else
            echo "Error: Division by zero is not allowed."
        fi
        ;;
    5)
        if [ "$num2" -ne 0 ]; then
            result=$((num1 % num2))
            echo "Result: $num1 % $num2 = $result"
        else
            echo "Error: Modulus by zero is not allowed."
        fi
        ;;
    *)
        echo "Invalid operation. Please choose a valid option (1-5)."
        ;;
esac
