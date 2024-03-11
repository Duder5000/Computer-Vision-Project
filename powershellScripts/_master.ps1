$folderPath = "G:\481\Computer-Vision-Project\powershellScripts\"

& "$folderPath\jsonToTxt.ps1"
Write-Host "Sleep 30s"
Start-Sleep -Seconds 30

& "$folderPath\getDims.ps1"
Write-Host "Sleep 30s"
Start-Sleep -Seconds 30
& "$folderPath\jsonToTxt.ps1"

& "$folderPath\combineTheTxts.ps1"
Write-Host "Sleep 30s"
Start-Sleep -Seconds 30

& "$folderPath\RemoveBlankLines.ps1"