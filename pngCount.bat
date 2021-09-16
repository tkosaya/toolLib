@echo off
setlocal EnableDelayedExpansion

set pngFile=pngFile.txt
set total=
echo memory analyze>!pngFile!

echo ====================>>!pngFile!

for /R %%s in (*.jpg,*png) do (
	set name=%%~ns
	set wd=
	set hi=
	
	for /f "delims=: tokens=1,2" %%i in ('mediainfo %%s') do (
		set first=%%i
		set sec=%%j
		
		
		if not "x!first:Width=!"=="x!first!" (
			set sec=!sec: =!
			set wd=!sec:pixels=!
		)
		
		if not "x!first:Height=!"=="x!first!" (
			set sec=!sec: =!
			set hi=!sec:pixels=!
		)
	)
	
	set /a mem=wd*hi/1024*4
	set /a total=total+mem
	echo FileName:!name!>>!pngFile!
	echo Size:!wd! x !hi!>>!pngFile!
	echo Memory:!mem!>>!pngFile!
	echo ====================>>!pngFile!
)

echo Total:!total!>>!pngFile!

pause