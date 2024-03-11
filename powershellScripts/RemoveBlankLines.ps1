$folderPath = "D:\Downloads\CombinedOutputFiles"

# Get all .txt files in the folder
$txtFiles = Get-ChildItem -Path $folderPath -Filter *.txt

# Loop through each .txt file
foreach ($file in $txtFiles) {
    # Read the content of the file
    $content = Get-Content -Path $file.FullName

    # Remove empty lines
    $content = $content | Where-Object { $_ -ne "" }

    # Write the updated content back to the file
    $content | Set-Content -Path $file.FullName
}

Write-Host "Empty lines removed from all .txt files in $folderPath"
