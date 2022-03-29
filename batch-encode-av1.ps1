# Change these
$ffmpegBinary = "C:\Users\tyler\Downloads\ffmpeg-1961492-af2b166-win64-nonfree\ffmpeg.exe"

$inputDir = "C:\Users\tyler\handbrake-input\"
$outputDir = "C:\Users\tyler\handbrake-output\"

# libaom-av1: https://trac.ffmpeg.org/wiki/Encode/AV1
# audio: https://trac.ffmpeg.org/wiki/Encode/HighQualityAudio

foreach ($file in Get-ChildItem -Path $inputDir)
{
	$finalInput = "" + $inputDir + $file + ""
	$finalOutput = "" + $outputDir + $file + ""
	& $ffmpegBinary -i $finalInput -c:v libaom-av1 -crf 30 -pix_fmt yuv420p10le -b:v 0 -cpu-used 2 -c:a libopus -b:a 128k $finalOutput
}
