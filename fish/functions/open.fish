function open
if test (count $argv) -eq 0
# If no arguments, open current directory in Finder
command open .
else
for item in $argv
if test -d $item
# If item is a directory, open it in Finder
command open $item
else if test -f $item
# If item is a file, open it with the default application
command open $item
else if string match -q -r '^https?://' $item
# If item is an http or https URL, open it in the default browser
command open $item
else
echo "Error: '$item' is not a valid file, directory, or http(s) URL."
end
end
end
end