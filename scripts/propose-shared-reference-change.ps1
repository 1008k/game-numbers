param(
  [Parameter(Mandatory = $true)]
  [string]$VendorPath,
  [string]$ProjectRoot = (Get-Location).Path,
  [string]$SharedRepo,
  [string]$CloneRoot = (Split-Path (Get-Location).Path -Parent),
  [switch]$ApplyVendorDiff
)

$ErrorActionPreference = "Stop"

function Read-LockValue([string]$Path, [string]$Key) {
  if (!(Test-Path $Path)) { return $null }
  $pattern = "^\s*$([regex]::Escape($Key)):\s*(.+?)\s*$"
  $match = Select-String -Path $Path -Pattern $pattern | Select-Object -First 1
  if (!$match) { return $null }
  return $match.Matches[0].Groups[1].Value.Trim('"').Trim("'")
}

$lockPath = Join-Path $ProjectRoot ".shared/shared-reference.lock.yaml"
if (!$SharedRepo) { $SharedRepo = Read-LockValue $lockPath "local_path" }
if (!$SharedRepo) { $SharedRepo = Join-Path $CloneRoot "shared-reference" }
if (![IO.Path]::IsPathRooted($SharedRepo)) { $SharedRepo = Join-Path $ProjectRoot $SharedRepo }
$SharedRepo = [IO.Path]::GetFullPath($SharedRepo)

if (!(Test-Path $SharedRepo)) {
  $repoUrl = Read-LockValue $lockPath "repo"
  if (!$repoUrl) { $repoUrl = "https://github.com/1008k/shared-reference.git" }
  New-Item -ItemType Directory -Force (Split-Path $SharedRepo -Parent) | Out-Null
  & git clone $repoUrl $SharedRepo
  if ($LASTEXITCODE -ne 0) { throw "Could not clone shared repo: $repoUrl" }
}

$script = Join-Path $SharedRepo "scripts/propose-shared-reference-change.ps1"
if (!(Test-Path $script)) { throw "Shared propose script not found: $script" }
& $script -VendorPath $VendorPath -ProjectRoot $ProjectRoot -SharedRepo $SharedRepo -CloneRoot $CloneRoot -ApplyVendorDiff:$ApplyVendorDiff