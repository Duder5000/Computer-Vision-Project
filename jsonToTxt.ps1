$jsonFilePath = "C:\Users\Duder5000\Downloads\O_1260.json"
$txtOutputFilePath = "C:\Users\Duder5000\Downloads\output.txt"

# Load the JSON file
$jsonContent = Get-Content -Raw -Path $jsonFilePath | ConvertFrom-Json

$allShapes = @()

# Iterate through each shape and create a custom object
foreach ($shape in $jsonContent.shapes) {
    
    #Write-Host $shape.points
    #Write-Host $shape.points[0][0]
    $x1 = $shape.points[0][0]
    #Write-Host $shape.points[0][1]
    $y1 = $shape.points[0][1]
    #Write-Host $shape.points[1][0]
    $x2 = $shape.points[1][0]
    #Write-Host $shape.points[1][1]
    $y2 = $shape.points[1][1]

    $pointsForThisShape = $x1.ToString() + ", " + $y1.ToString() + ", " + $x2.ToString() + ", " + $y2.ToString()
    #Write-Host $pointsForThisShape

    $shapeInfo = [PSCustomObject]@{
        ShapeType = $shape.shape_type
        Label     = $shape.label
        #Points    = $shape.points -join ','
        Points    = $pointsForThisShape -join ','
    }

    $allShapes += $shapeInfo
}

# Output the shape information to a text file
$allShapes | ForEach-Object { "$($_.ShapeType), $($_.Label), $($_.Points)" } | Out-File -FilePath $txtOutputFilePath -Encoding UTF8