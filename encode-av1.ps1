# Change these
$ffmpegBinary = "C:\Users\tyler\bin\ffmpeg-2022-04-25-git-f2724d2b69-full_build\bin\ffmpeg.exe"

# libaom-av1: https://trac.ffmpeg.org/wiki/Encode/AV1
# audio: https://trac.ffmpeg.org/wiki/Encode/HighQualityAudio
$crf = 30
$cpuUsed = 4
$audioCodec = "libopus"
$audioBitrate = "128k"
$10bit = "yes"
$copyAudio = "no"


$inputFile = Read-Host -Prompt "Source file"
$outputFile = Read-Host -Prompt "Output file"

$skipPreview = "no"

if ($skipPreview -eq "no")
{
	Write-Host ""
	Write-Host "Input: $inputFile"
	Write-Host "Output: $outputFile"
	Write-Host "10bit video: $10bit"
	Write-Host "crf value: $crf"
	Write-Host "libaom-av1 CPU used: $cpuUsed"
	
	if ($copyAudio -eq "no")
	{
		Write-Host "Audio codec: $audioCodec"
		Write-Host "Audio bitrate: $audioBitrate"	
	} else
	{
		Write-Host "Copy audio: yes"
	}

	Write-Host ""
	Write-Host "Important!"
	Write-Host "1) Make sure to double check the options in this script. If you are not sure if they are correct, answer no now."
	Write-Host "2) Make sure your input/output file is the full path and is in quotes."
	Write-Host ""

	$confirm = Read-Host -Prompt "Is this okay? (Y/n)"
	if ($confirm -ne "Y")
	{
		exit
	}
}


# 10bit section
if ($10bit -eq "yes" -and $copyAudio -eq "no")
{
	& $ffmpegBinary -i $inputFile -c:v libaom-av1 -crf $crf -pix_fmt yuv420p10le -b:v 0 -cpu-used $cpuUsed -c:a $audioCodec -b:a $audioBitrate $outputFile
}

if ($10bit -eq "yes" -and $copyAudio -eq "yes")
{
	& $ffmpegBinary -i $inputFile -c:v libaom-av1 -crf $crf -pix_fmt yuv420p10le -b:v 0 -cpu-used $cpuUsed -c:a copy $outputFile
}

# not 10bit section
if ($10bit -eq "no" -and $copyAudio -eq "no")
{
	& $ffmpegBinary -i $inputFile -c:v libaom-av1 -crf $crf -b:v 0 -cpu-used $cpuUsed -c:a $audioCodec -b:a $audioBitrate $outputFile
}

if ($10bit -eq "no" -and $copyAudio -eq "yes")
{
	& $ffmpegBinary -i $inputFile -c:v libaom-av1 -crf $crf -b:v 0 -cpu-used $cpuUsed -c:a copy $outputFile
}
