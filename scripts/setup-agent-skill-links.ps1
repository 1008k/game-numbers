param(
  [string]$ProjectRoot = (Get-Location).Path,
  [string]$SharedSkillsPath,
  [string[]]$AgentSkillRoots = @(".agents/skills", ".claude/skills")
)

$ErrorActionPreference = "Stop"

function Get-FullPath([string]$BasePath, [string]$Path) {
  if ([IO.Path]::IsPathRooted($Path)) {
    return [IO.Path]::GetFullPath($Path)
  }
  return [IO.Path]::GetFullPath((Join-Path $BasePath $Path))
}

function Get-RelativePath([string]$FromDirectory, [string]$ToPath) {
  $from = [IO.Path]::GetFullPath($FromDirectory).TrimEnd([IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar)
  $to = [IO.Path]::GetFullPath($ToPath).TrimEnd([IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar)

  if (![StringComparer]::OrdinalIgnoreCase.Equals([IO.Path]::GetPathRoot($from), [IO.Path]::GetPathRoot($to))) {
    return $to
  }

  $fromParts = $from.Substring([IO.Path]::GetPathRoot($from).Length).Split([IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar)
  $toParts = $to.Substring([IO.Path]::GetPathRoot($to).Length).Split([IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar)

  $common = 0
  while (
    $common -lt $fromParts.Length -and
    $common -lt $toParts.Length -and
    [StringComparer]::OrdinalIgnoreCase.Equals($fromParts[$common], $toParts[$common])
  ) {
    $common++
  }

  $relativeParts = @()
  for ($i = $common; $i -lt $fromParts.Length; $i++) { $relativeParts += ".." }
  for ($i = $common; $i -lt $toParts.Length; $i++) { $relativeParts += $toParts[$i] }
  if (!$relativeParts) { return "." }
  return ($relativeParts -join [IO.Path]::DirectorySeparatorChar)
}

function Resolve-LinkTarget([IO.FileSystemInfo]$Item) {
  if (!$Item.Attributes.HasFlag([IO.FileAttributes]::ReparsePoint)) { return $null }
  if (!$Item.Target) { return $null }

  $target = $Item.Target
  if ($target -is [array]) { $target = $target[0] }
  if ([IO.Path]::IsPathRooted($target)) {
    return [IO.Path]::GetFullPath($target)
  }

  return [IO.Path]::GetFullPath((Join-Path $Item.Parent.FullName $target))
}

function Test-SamePath([string]$Left, [string]$Right) {
  return [StringComparer]::OrdinalIgnoreCase.Equals(
    [IO.Path]::GetFullPath($Left).TrimEnd([IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar),
    [IO.Path]::GetFullPath($Right).TrimEnd([IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar)
  )
}

function New-SkillLink([string]$LinkPath, [string]$TargetPath) {
  $linkParent = Split-Path -Path $LinkPath -Parent
  New-Item -ItemType Directory -Force -Path $linkParent | Out-Null

  if (Test-Path -LiteralPath $LinkPath) {
    $item = Get-Item -LiteralPath $LinkPath -Force
    $currentTarget = Resolve-LinkTarget $item

    if ($currentTarget -and (Test-SamePath $currentTarget $TargetPath)) {
      Write-Host "OK: $LinkPath -> $TargetPath"
      return $true
    }

    if ($currentTarget) {
      Write-Warning "Skip: $LinkPath already links to $currentTarget"
      return $false
    }

    Write-Warning "Skip: $LinkPath already exists and is not a link."
    return $false
  }

  $relativeTarget = Get-RelativePath $linkParent $TargetPath
  try {
    Push-Location $linkParent
    try {
      New-Item -ItemType SymbolicLink -Path (Split-Path -Path $LinkPath -Leaf) -Target $relativeTarget | Out-Null
    } finally {
      Pop-Location
    }
    Write-Host "Created symlink: $LinkPath -> $relativeTarget"
    return $true
  } catch {
    $isWindowsRuntime = $env:OS -eq "Windows_NT"
    if ((Get-Variable -Name IsWindows -Scope Global -ErrorAction SilentlyContinue) -and !$IsWindows) {
      $isWindowsRuntime = $false
    }
    if (!$isWindowsRuntime) { throw }
    Write-Warning "Could not create symlink for $LinkPath; falling back to junction. $($_.Exception.Message)"
  }

  New-Item -ItemType Junction -Path $LinkPath -Target $TargetPath | Out-Null
  Write-Host "Created junction: $LinkPath -> $TargetPath"
  return $true
}

function Convert-To-GitIgnorePath([string]$ProjectRoot, [string]$Path) {
  $relativePath = Get-RelativePath $ProjectRoot $Path
  return $relativePath.Replace([IO.Path]::DirectorySeparatorChar, "/")
}

function Add-LocalGitExcludes([string]$ProjectRoot, [string[]]$Paths) {
  $gitDirectory = Join-Path $ProjectRoot ".git"
  if (!(Test-Path -LiteralPath $gitDirectory)) { return }

  $excludePath = Join-Path $gitDirectory "info/exclude"
  $excludeDirectory = Split-Path -Path $excludePath -Parent
  New-Item -ItemType Directory -Force -Path $excludeDirectory | Out-Null

  $existing = @()
  if (Test-Path -LiteralPath $excludePath) {
    $existing = Get-Content -LiteralPath $excludePath
  }

  $entries = @("# Generated local links to shared agent skills")
  foreach ($path in $Paths) {
    $entries += Convert-To-GitIgnorePath $ProjectRoot $path
  }

  $newEntries = $entries | Where-Object { $existing -notcontains $_ }
  if ($newEntries) {
    Add-Content -LiteralPath $excludePath -Value $newEntries
  }
}

$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot)
if (!$SharedSkillsPath) { $SharedSkillsPath = ".shared/skills" }
$sharedSkillsRoot = Get-FullPath $ProjectRoot $SharedSkillsPath

if (!(Test-Path -LiteralPath $sharedSkillsRoot)) {
  throw ".shared/skills is not synced. Run scripts/sync-shared-reference.ps1 first."
}

$skills = Get-ChildItem -LiteralPath $sharedSkillsRoot -Directory |
  Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName "SKILL.md") } |
  Sort-Object Name

if (!$skills) {
  throw "No shared skills found under .shared/skills. Run scripts/sync-shared-reference.ps1 first."
}

$generatedLinkPaths = @()
foreach ($agentRoot in $AgentSkillRoots) {
  $agentRootPath = Get-FullPath $ProjectRoot $agentRoot

  foreach ($skill in $skills) {
    $linkPath = Join-Path $agentRootPath $skill.Name
    if (New-SkillLink $linkPath $skill.FullName) {
      $generatedLinkPaths += $linkPath
    }
  }
}

Add-LocalGitExcludes $ProjectRoot $generatedLinkPaths
