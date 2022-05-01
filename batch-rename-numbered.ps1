# Rename all files in a folder with a certain extension to count up.
# This is useful if your files have really long names and they are already in order.
# This script needs to be modified if you aren't working with .txt files.

# After running this script, I recommend you preappend a 0 to the files that are numbered under 10.
# Example: rename 1.txt to 01.txt and so on..

$files = "C:\Users\tyler\test\*.txt"

Get-ChildItem -Path $files | ForEach-Object -Begin {$counter=1} -Process {Rename-Item $_ "$counter.txt"; $counter++}
