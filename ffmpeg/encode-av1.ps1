# Change this is ffmpeg is not in your PATH
$ffmpegBinary = "ffmpeg"

$inputFile = Read-Host -Prompt "Source file"
$outputFile = Read-Host -Prompt "Output file"
$10bit = Read-Host -Prompt "10bit video (y/n)"
$crf = Read-Host -Prompt "CRF (Example: '30')"
$cpuUsed = Read-Host -Prompt "AV1 CPU Used (Example: '4')"

$copyAudio = Read-Host -Prompt "Copy audio (y/n)"

if ($copyAudio -eq "n") {
    $audioCodec = Read-Host -Prompt "Audio codec (Example: 'libopus')"
    $audioBitrate = Read-Host -Prompt "Audio bitrate (Example: '128k')"
}

$skipPreview = "no"

if ($skipPreview -eq "no") {
	Write-Host ""
	Write-Host "Input: $inputFile"
	Write-Host "Output: $outputFile"
	Write-Host "10bit video: $10bit"
	Write-Host "crf value: $crf"
	Write-Host "libaom-av1 CPU used: $cpuUsed"
	
	if ($copyAudio -eq "n") {
		Write-Host "Audio codec: $audioCodec"
		Write-Host "Audio bitrate: $audioBitrate"	

	} else {
		Write-Host "Copy audio: yes"
	}
        Write-Host ""
        Write-Host "Important!"
        Write-Host "1) Make sure to double check the options in this script. If you are not sure if they are correct, answer no now."
        Write-Host "2) Make sure your input/output file is the full path and is in quotes."
        Write-Host "3) See https://trac.ffmpeg.org/wiki/Encode/AV1 and https://trac.ffmpeg.org/wiki/Encode/HighQualityAudio"
        Write-Host ""

	$confirm = Read-Host -Prompt "Is this okay? (y/n)"
	if ($confirm -ne "y") {
		exit
	}
}

# 10bit section
if ($10bit -eq "y" -and $copyAudio -eq "n") {
	& $ffmpegBinary -i $inputFile -c:v libaom-av1 -crf $crf -pix_fmt yuv420p10le -b:v 0 -cpu-used $cpuUsed -c:a $audioCodec -b:a $audioBitrate $outputFile
}

if ($10bit -eq "y" -and $copyAudio -eq "y") {
	& $ffmpegBinary -i $inputFile -c:v libaom-av1 -crf $crf -pix_fmt yuv420p10le -b:v 0 -cpu-used $cpuUsed -c:a copy $outputFile
}

# not 10bit section
if ($10bit -eq "n" -and $copyAudio -eq "n") {
	& $ffmpegBinary -i $inputFile -c:v libaom-av1 -crf $crf -b:v 0 -cpu-used $cpuUsed -c:a $audioCodec -b:a $audioBitrate $outputFile
}

if ($10bit -eq "n" -and $copyAudio -eq "y") {
	& $ffmpegBinary -i $inputFile -c:v libaom-av1 -crf $crf -b:v 0 -cpu-used $cpuUsed -c:a copy $outputFile
}
