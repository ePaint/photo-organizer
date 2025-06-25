[XML]$Settings = Get-Content -Path "Settings.xml"
$ProjectRootPath = $Settings.root.ProjectRootPath

$360EditsFolderPath = Join-Path -Path $ProjectRootPath -ChildPath "360 Edits"
if (-not (Test-Path -Path $360EditsFolderPath)) {
  New-Item -Path $360EditsFolderPath -ItemType Directory | Out-Null
}

$OriginalsFolderPath = Join-Path -Path $360EditsFolderPath -ChildPath "Originals"
if (-not (Test-Path -Path $OriginalsFolderPath)) {
  New-Item -Path $OriginalsFolderPath -ItemType Directory | Out-Null
}

$EditsFolderPath = Join-Path -Path $360EditsFolderPath -ChildPath "Edits"
if (-not (Test-Path -Path $EditsFolderPath)) {
  New-Item -Path $EditsFolderPath -ItemType Directory | Out-Null
}

Function Get-FolderFromName {
  [CmdletBinding()]
  param (
      $Name
  )
  $Segments = $Name -split '-'
  $FloorName = $Segments[0] -replace "_", " "
  $IDName = $Segments[1] -replace "_", " "
  $FloorPath = Join-Path -Path $ProjectRootPath -ChildPath $FloorName
  $IDPath = Join-Path -Path $FloorPath -ChildPath $IDName
  return $IDPath
}

$Items = Get-ChildItem -Path $ProjectRootFolderPath -Recurse -Filter "*-h1-edit.jpg"
$Items | ForEach-Object {
  $Segments = $_.Name -split '-'
  $FloorName = $Segments[0] -replace "_", " "
  $IDName = $Segments[1] -replace "_", " "
  $FloorPath = Join-Path -Path $ProjectRootPath -ChildPath $FloorName
  $IDPath = Join-Path -Path $FloorPath -ChildPath $IDName
  if (-not (Test-Path -Path $IDPath)) {
    Write-Host "Folder $IDPath does not exist, skipping item $($_.Name)" -ForegroundColor Yellow
    return
  }
  Copy-Item -Path $_.FullName -Destination "$IDPath/h1.jpg" -Force
}

