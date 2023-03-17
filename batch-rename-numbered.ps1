# Rename all files in a folder with a certain extension to count up.
# This is useful if your files have really long names and they are already in order.
# This script needs to be modified if you aren't working with .txt files.

$files = "C:\Users\tyler\test\*.txt"

Get-ChildItem -Path $files | ForEach-Object -Begin {$counter=1} -Process {

    if ($counter -lt 10) {
        Rename-Item $_ "0$counter.txt";
        $counter++;
    } else {
        Rename-Item $_ "$counter.txt";
        $counter++
    }
}