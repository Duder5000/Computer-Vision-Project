# Load the System.Drawing assembly
Add-Type -AssemblyName System.Drawing

# Specify the folder path
$folderPath = "D:\Downloads\JpgFiles"
$outputFolderPath = "D:\Downloads\OutputImgSize"

# Ensure the output folder exists, create it if necessary
if (-not (Test-Path -Path $outputFolderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $outputFolderPath | Out-Null
}

# Get all .jpg files in the folder
$jpgFiles = Get-ChildItem -Path $folderPath -Filter *.jpg

# Loop through each .jpg file
foreach ($jpgFile in $jpgFiles) {
    # Generate output file path based on the input file name
    $outputFileName = [System.IO.Path]::ChangeExtension($jpgFile.BaseName, 'txt')
    $outputFilePath = Join-Path -Path $outputFolderPath -ChildPath $outputFileName
    
    $image = [System.Drawing.Image]::FromFile($jpgFile.FullName)

    # Get the width and height of the image
    $width = $image.Width
    $height = $image.Height
    $dimString = "$width, $height"

    # Write the dimensions to the output text file
    $dimString | Out-File -FilePath $outputFilePath -Force

    $image.Dispose()
}