$dir = "C:\Users\tyler\test\"
$counter = 1

while ($counter -lt 100)
{
    New-Item -Path $dir -ItemType File -Name test-$counter.txt
    $counter++
}
