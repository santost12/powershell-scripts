# Change these for your computer

$ffmpegBinary = "C:\Users\tyler\Downloads\ffmpeg-1bed27a-af2b166-win64-nonfree\ffmpeg.exe"

$inputDir = "C:\Users\tyler\handbrake-input\"
$outputDir = "C:\Users\tyler\handbrake-output\"

$skipPreview = "yes"

if ($skipPreview -eq "no")
{
	foreach ($file in Get-ChildItem -Path $inputDir)
	{
		$finalInput = "" + $inputDir + $file + ""
		$finalOutput = "" + $outputDir + $file + ""
		Write-Host "$finalInput" "-->" "$finalOutput"
	}

	Write-Host ""
	Write-Host "Input folder: $inputDir"
	Write-Host "Output folder: $outputDir"

	Write-Host ""
	Write-Host "Important!"
	Write-Host "1) Make sure to double check the ffmpeg arguments in this script. If you are not sure if they are correct, answer no now."
	Write-Host "2) Make sure your output folder is empty or doesn't already have files with the same names as your input folder."
	Write-Host ""

	$confirm = Read-Host -Prompt "Is this okay? (Y/n)"
	if ($confirm -ne "Y")
	{
		exit
	}
}

foreach ($file in Get-ChildItem -Path $inputDir)
{
	$finalInput = "" + $inputDir + $file + ""
	$finalOutput = "" + $outputDir + $file + ""
	& $ffmpegBinary -i $finalInput -c:v libaom-av1 -crf 30 -pix_fmt yuv420p10le -b:v 0 -cpu-used 2 -c:a libopus -b:a 128k $finalOutput
}
