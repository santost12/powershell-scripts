# Uses the current working directory.
# Run this script by typing the full location or add the folder it is in to your PATH

$7zipBinary = "C:\Program Files\7-Zip\7z.exe"
$skipConfirmation = "no"

if ($skipConfirmation = "no") {
    $folders = Get-ChildItem -Directory -Path $PWD
    Write-Host "7zip archives will be created for"$folders.count"folders in: "$PWD""
	$folders.Name
	
	$confirm = Read-Host -Prompt "Is this okay? (y/n)"
	
	if ($confirm -ne "y") {
        exit
    }
}

Get-ChildItem -Directory -Path $PWD | ForEach-Object -Process { & $7zipBinary a $_ $_ }