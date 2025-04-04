#!/bin/bash
echo "Enter the username to check if they are logged in:"
read username

if who | grep -w "$username" > /dev/null; then 
    echo "User $username is currently logged in."
else
    echo "User $username is not logged in."
fi
