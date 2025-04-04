echo "Enter the filename:"
read filename
echo "Enter the string to search:"
read search_str
echo "Enter the replacement string:"
read replace_str
sed -i '' "s/$search_str/$replace_str/g" "$filename"
echo "String replacement completed"