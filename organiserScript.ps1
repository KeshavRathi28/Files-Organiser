param([string]$source = ".\Source", [string]$destination = ".\Destination")

function  Check-Folder ([string]$path, [switch]$create) {
    $exists = Test-Path $path
    if (!$exists -and $create) {
        mkdir $path | Out-Null
        $exists = Test-Path $path
    }
    return $exists
}

function Display-FolderStats ([string]$path) {
    $files = Get-ChildItem $path -Recurse | Where-Object { !$_.PSIsContainer }
    $totals = $files | Measure-Object -Property Length -Sum
    $stats = "" | Select-Object path, count, size
    $stats.path = $path
    $stats.count = $totals.Count
    $stats.size = [math]::Round($totals.Sum / 1MB, 3)
    return $stats
}


$sourceExists = Check-Folder $source

if (!$sourceExists) {
    Write-Host "The source directory not found, script cannot continue..."
    Exit
}

$destinationExists = Check-Folder $destination -create

if (!$destinationExists) {
    Write-Host "The destination directory not found, script cannot continue..."
    Exit
}


$files = Get-ChildItem $source -Recurse | Where-Object { !$_.PSIsContainer }

foreach ($file in $files) {
    $ext = $file.Extension.Replace(".", "")
    $extDir = "$destination\$ext"
    $extDirExists = Check-Folder $extDir -create

    if (!$extDirExists) {
        Write-Host "The destination directory ($extDir) cannot be created."
        Exit
    }

    Copy-Item $file.FullName $extDir
}


$dirs = Get-ChildItem $destination | Where-Object { $_.PSIsContainer }

$allStats = @()
foreach ($dir in $dirs) {
    $allStats += Display-FolderStats $dir.FullName
}

$allStats | Sort-Object size -Descending