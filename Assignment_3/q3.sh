echo "Enter the number of terms for Fibonacci sequence:"
read n 
a=0
b=1
echo "Fibonacci sequence:" 
for (( i=0; i<n; i++ ))
do
    echo -n "$a " 
    fn=$((a + b))
    a=$b 
    b=$fn
done 
echo