# Function to show folder browser dialog
function Get-FolderBrowserDialog {
    Add-Type -AssemblyName System.Windows.Forms
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = "Select a folder"
    $folderBrowser.RootFolder = [System.Environment+SpecialFolder]::MyComputer
    $folderBrowser.SelectedPath = [System.IO.Directory]::GetCurrentDirectory()

    [System.Windows.Forms.DialogResult]$result = $folderBrowser.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $folderBrowser.SelectedPath
    } else {
        return $null
    }
}

# Prompt the user to select a folder
$jsonFolderPath = Get-FolderBrowserDialog

if (-not $jsonFolderPath) {
    Write-Host "No folder selected. Exiting."
    Exit
}

# Ensure the output folder exists, create it if necessary
$outputFolderPath = "C:\Users\Duder5000\Downloads\OutputFiles"
if (-not (Test-Path -Path $outputFolderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $outputFolderPath | Out-Null
}

# Get all JSON files in the specified folder
$jsonFiles = Get-ChildItem -Path $jsonFolderPath -Filter *.json

foreach ($jsonFile in $jsonFiles) {
    # Generate output file path based on the input file name
    $outputFileName = [System.IO.Path]::ChangeExtension($jsonFile.BaseName, 'txt')
    $outputFilePath = Join-Path -Path $outputFolderPath -ChildPath $outputFileName

    # Load the JSON file
    $jsonContent = Get-Content -Raw -Path $jsonFile.FullName | ConvertFrom-Json

    $allShapes = @()

    # Iterate through each shape and create a custom object
    foreach ($shape in $jsonContent.shapes) {
        $x1 = $shape.points[0][0]
        $y1 = $shape.points[0][1]
        $x2 = $shape.points[1][0]
        $y2 = $shape.points[1][1]

        $pointsForThisShape = "$x1, $y1, $x2, $y2"

        $shapeInfo = [PSCustomObject]@{
            ShapeType = $shape.shape_type
            Label     = $shape.label
            Points    = $pointsForThisShape -join ','
        }

        $allShapes += $shapeInfo
    }

    # Output the shape information to a text file
    $allShapes | ForEach-Object { "$($_.ShapeType), $($_.Label), $($_.Points)" } | Out-File -FilePath $outputFilePath -Encoding UTF8
}