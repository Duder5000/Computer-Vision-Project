$jsonFolderPath = "C:\Users\Duder5000\Downloads\JsonFiles"
$outputFolderPath = "C:\Users\Duder5000\Downloads\OutputFiles"

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