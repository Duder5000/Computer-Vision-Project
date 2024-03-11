$infoFolderPath = "D:\Downloads\OutputFiles"
$dimsFolderPath = "D:\Downloads\OutputImgSize"
$outputFolderPath = "D:\Downloads\CombinedOutputFiles"

# Ensure the output folder exists, create it if necessary
if (-not (Test-Path -Path $outputFolderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $outputFolderPath | Out-Null
}

# Get all .txt files in $infoFolderPath
$infoFiles = Get-ChildItem -Path $infoFolderPath -Filter *.txt

foreach ($infoFile in $infoFiles) {
    # Construct the path to the corresponding file in $dimsFolderPath
    $dimsFilePath = Join-Path -Path $dimsFolderPath -ChildPath $infoFile.Name

    # Check if the corresponding file in $dimsFolderPath exists
    if (Test-Path -Path $dimsFilePath -PathType Leaf) {
        # Read the content of both files, combine with a new line, and save to the output folder
        $contentInfo = Get-Content -Path $infoFile.FullName -Raw
        $contentDims = Get-Content -Path $dimsFilePath -Raw

        # Combine the content and remove extra new lines
        $combinedContent = "$contentDims`n$contentInfo" -replace "(\r\n?|\n){2,}", "`n"

        $combinedFilePath = Join-Path -Path $outputFolderPath -ChildPath $infoFile.Name
        $combinedContent | Set-Content -Path $combinedFilePath
    }
    else {
        Write-Warning "Corresponding file not found for $($infoFile.Name) in $dimsFolderPath."
    }
}