# Change these
$ffmpegBinary = "ffmpeg"

$inputDir = "C:\Users\tyler\handbrake-input\"
$outputDir = "C:\Users\tyler\handbrake-output\"

# libaom-av1: https://trac.ffmpeg.org/wiki/Encode/AV1
# audio: https://trac.ffmpeg.org/wiki/Encode/HighQualityAudio

foreach ($file in Get-ChildItem -Path $inputDir)
{
	$finalInput = "" + $inputDir + $file + ""
	$finalOutput = "" + $outputDir + $file + ""
	& $ffmpegBinary -i $finalInput -c:v libx265 -crf 30 -preset slow -c:a libopus -b:a 128k $finalOutput
}
