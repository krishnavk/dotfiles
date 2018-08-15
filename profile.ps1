#Author: vhanla
#Force coloring of git and npm commands 
$env:TERM = 'cygwin'
$env:TERM = 'FRSX'
$env:TERM = 'xterm'

$global:foregroundColor = 'white'
$time = Get-Date
$psVersion= $host.Version.Major
$curUser= (Get-ChildItem Env:\USERNAME).Value
$curComp= (Get-ChildItem Env:\COMPUTERNAME).Value


function Prompt {
	# Prompt Colors
	# Black DarkBlue DarkGreen DarkCyan DarkRed DarkMagenta DarkYellow
	# Gray DarkGray Blue Green Cyan Red Magenta Yellow White

	$prompt_text = "White"
	$prompt_background = "Blue"
	$prompt_git_background = "DarkGreen"	
	$prompt_git_text = "Black"	
	
	# Grab Git Branch
	$git_string = "";
	git branch | foreach {
		if ($_ -match "^\* (.*)"){
			$git_string += $matches[1]
		}
	}
		
	# Grab Git Status
	$git_status = "";
	git status --porcelain | foreach {
		$git_status = $_ #just replace other wise it will be empty
	}
	
	if (!$git_string)	{
		$prompt_text = "White"
		$prompt_background = "Blue"
	}
	
	if ($git_status){
		$prompt_git_background = "Yellow"
	}
	

$curtime = Get-Date
# $PWD = PWD
$path = PWD
# Write-Host -NoNewLine "[" -foregroundColor $prompt_text -backgroundColor $prompt_background
# Write-Host -NoNewLine ("{0:HH}:{0:mm}:{0:ss}" -f (Get-Date)) -foregroundColor $prompt_text -backgroundColor $prompt_background
# Write-Host -NoNewLine "]" -foregroundColor $prompt_text -backgroundColor $prompt_background
Write-Host (Split-Path $path -leaf) -foregroundColor $prompt_text -backgroundColor $prompt_background -NoNewLine
if ($git_string){
	Write-Host  "$([char]57520)" -foregroundColor $prompt_background -NoNewLine -backgroundColor $prompt_git_background
	Write-Host  " $([char]57504) " -foregroundColor $prompt_git_text -backgroundColor $prompt_git_background -NoNewLine 	
	Write-Host ($git_string)  -NoNewLine -foregroundColor $prompt_git_text -backgroundColor $prompt_git_background
	Write-Host  "$([char]57520)" -foregroundColor $prompt_git_background -NoNewLine
}
else{
	Write-Host  "$([char]57520)" -foregroundColor $prompt_background -NoNewLine
}

$host.UI.RawUI.WindowTitle = "PS >> User: $curUser >> Current DIR: $((Split-Path (Get-Location).Path))"

Return " "

}
