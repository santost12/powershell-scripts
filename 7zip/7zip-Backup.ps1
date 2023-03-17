$7zipBinary = "C:\Program Files\7-Zip\7z.exe"
$date = Get-Date -UFormat "%Y-%m-%d-%s"
$counter = 0

# For each folder you want to backup,
# you must include the full path where
# you want to save the 7z archive.

$source = @("C:\Users\tyler\Documents\blender\", "C:\Users\tyler\Documents\Example2\")
$output = @("E:\7zip-backups\blender-$date.7z", "E:\7zip-backups\Example2-$date.7z")

foreach ($path in $source) {
    & $7zipBinary a -mx5 $output[$counter] $path
    $counter++
}

# If you want to copy the backups to another
# location, you can do so here.

foreach ($path in $output) {
    Copy-Item $path F:\7zip-backups\
}
