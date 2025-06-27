[XML]$Settings = Get-Content -Path "Settings.xml"
$VirtualProjectRootPath = $Settings.root.ProjectRootPath

$PhotosProjectRootPath = "$VirtualProjectRootPath Photos"
if (-not (Test-Path -Path $PhotosProjectRootPath)) {
  New-Item -Path $PhotosProjectRootPath -ItemType Directory | Out-Null
}

$360EditsFolderPath = Join-Path -Path $PhotosProjectRootPath -ChildPath "360 Edits"
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

$Items = Get-ChildItem -Path $VirtualProjectRootPath -Recurse -Filter "h1.jpg"
$Items | ForEach-Object {
  $Item = $_
  $ID = Get-Item -Path $Item.DirectoryName
  $Floor = $ID.Parent
  $NewName = "$($Floor.Name -replace " ", "_")-$($ID.Name)-h1.jpg"
  $NewPath = Join-Path -Path $OriginalsFolderPath -ChildPath $NewName

  "Copying item $NewName"
  Copy-Item -Path $Item.FullName -Destination $NewPath -Force
}