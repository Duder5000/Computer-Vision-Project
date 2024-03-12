$folderPath = "G:\481\Computer-Vision-Project\powershellScripts\"

& "$folderPath\jsonToTxt.ps1"
Write-Host "jsonToTxt - Sleep 20s"
Start-Sleep -Seconds 20

& "$folderPath\getDims.ps1"
Write-Host "getDims - Sleep 20s"
Start-Sleep -Seconds 20

& "$folderPath\combineTheTxts.ps1"
Write-Host "combineTheTxts - Sleep 20s"
Start-Sleep -Seconds 20

& "$folderPath\RemoveBlankLines.ps1"