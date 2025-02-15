function pdf
set input_file $argv[1]

# Check if the file exists
if not test -f $input_file
echo "Error: File not found: $input_file"
return 1
end

# Extract the base name without extension
set base_name (string replace -r '\.md$' '' $input_file)

# Create the output file name
set output_file "$base_name.pdf"

# Run pandoc
pandoc "$input_file" -o "$output_file"

if test $status -eq 0
echo "Successfully converted $input_file to $output_file"
else
echo "Error: Conversion failed"
end
end