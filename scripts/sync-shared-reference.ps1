param(
  [string]$ProjectRoot = (Get-Location).Path,
  [string]$SharedRepo,
  [string]$Ref,
  [string]$LockPath,
  [string]$CloneRoot = (Split-Path (Get-Location).Path -Parent),
  [switch]$Force,
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"

function Read-LockValue([string]$Path, [string]$Key) {
  if (!(Test-Path $Path)) { return $null }
  $pattern = "^\s*$([regex]::Escape($Key)):\s*(.+?)\s*$"
  $match = Select-String -Path $Path -Pattern $pattern | Select-Object -First 1
  if (!$match) { return $null }
  return $match.Matches[0].Groups[1].Value.Trim('"').Trim("'")
}

if (!$LockPath) { $LockPath = Join-Path $ProjectRoot ".shared/shared-reference.lock.yaml" }
if (!$SharedRepo) { $SharedRepo = Read-LockValue $LockPath "local_path" }
if (!$SharedRepo) { $SharedRepo = Join-Path $CloneRoot "shared-reference" }
if (![IO.Path]::IsPathRooted($SharedRepo)) { $SharedRepo = Join-Path $ProjectRoot $SharedRepo }
$SharedRepo = [IO.Path]::GetFullPath($SharedRepo)

if (!(Test-Path $SharedRepo)) {
  $repoUrl = Read-LockValue $LockPath "repo"
  if (!$repoUrl) { $repoUrl = "https://github.com/1008k/shared-reference.git" }
  New-Item -ItemType Directory -Force (Split-Path $SharedRepo -Parent) | Out-Null
  & git clone $repoUrl $SharedRepo
  if ($LASTEXITCODE -ne 0) { throw "Could not clone shared repo: $repoUrl" }
}

$script = Join-Path $SharedRepo "scripts/sync-shared-reference.ps1"
if (!(Test-Path $script)) { throw "Shared sync script not found: $script" }
& $script -ProjectRoot $ProjectRoot -SharedRepo $SharedRepo -Ref $Ref -LockPath $LockPath -Force:$Force -DryRun:$DryRun