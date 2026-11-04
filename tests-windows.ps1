$ErrorActionPreference = 'Stop'
. ([scriptblock]::Create([IO.File]::ReadAllText((Join-Path $PSScriptRoot 'prepare-windows.ps1'))))
$script:passed = 0
function Assert-Test([bool]$Value, [string]$Name) {
    if (-not $Value) { throw "FAILED: $Name" }
    $script:passed++
    Write-Host "PASS: $Name"
}
Assert-Test (Test-CourseNode 'v24.1.0' ([datetime]'2026-11-04')) 'Node 24 LTS is retained'
Assert-Test (-not (Test-CourseNode 'v20.1.0' ([datetime]'2026-11-04'))) 'EOL Node is rejected'
Assert-Test (-not (Test-CourseNode 'v22.1.0' ([datetime]'2027-04-30'))) 'LTS expiry boundary is enforced'
Assert-Test (-not (Test-CourseNode 'v26.1.0' ([datetime]'2026-10-01'))) 'pre-LTS Node is rejected'
Assert-Test (-not (Test-CourseNode 'v24.1.0-beta' ([datetime]'2026-11-04'))) 'prerelease Node is rejected'

# Isolated scenarios: no installer, account, project, or user settings are changed.
function Reset-Scenario {
    $script:missingNode=$false; $script:missingGit=$false; $script:missingNpm=$false
    $script:brokenNode=$false; $script:version='v24.1.0'; $script:installs=0
    $script:extensions=@('dbaeumer.vscode-eslint','esbenp.prettier-vscode')
}
function Find-CourseTool([string]$Name) {
    if ($Name -eq 'node.exe' -and $script:missingNode) { return $null }
    if ($Name -eq 'npm.cmd' -and $script:missingNpm) { return $null }
    if ($Name -eq 'git.exe' -and $script:missingGit) { return $null }
    return (Join-Path $env:TEMP $Name)
}
function Read-CourseVersion([string]$File) {
    switch ([IO.Path]::GetFileName($File)) {
        'git.exe' { return 'git version 2.50.0' }
        'node.exe' { if ($script:brokenNode) { throw 'Existing Node did not start.' }; return $script:version }
        'npm.cmd' { return '11.1.0' }
    }
}
function Read-Host { return 'Y' }
function Install-MissingNode { $script:installs++; $script:missingNode=$false; $script:missingNpm=$false }
function Install-MissingGit { $script:installs++; $script:missingGit=$false }
function Get-CourseExtensions { return $script:extensions }
function Install-CourseExtension([string]$Code,[string]$Id) { $script:installs++; $script:extensions+= $Id }

Reset-Scenario
$result=Invoke-ProjectSetup
Assert-Test ($result -eq 0 -and $script:installs -eq 0) 'all existing tools skip installation'
Reset-Scenario; $script:missingNode=$true; $script:missingNpm=$true
$result=Invoke-ProjectSetup -CheckOnly
Assert-Test ($result -eq 1 -and $script:installs -eq 0) 'check-only never installs missing Node'
Reset-Scenario; $script:missingNode=$true; $script:missingNpm=$true
$result=Invoke-ProjectSetup
Assert-Test ($result -eq 0 -and $script:installs -eq 1) 'only missing Node is installed'
Reset-Scenario; $script:missingGit=$true
$result=Invoke-ProjectSetup
Assert-Test ($result -eq 0 -and $script:installs -eq 1) 'only missing Git is installed'
Reset-Scenario; $script:brokenNode=$true
$result=Invoke-ProjectSetup
Assert-Test ($result -eq 1 -and $script:installs -eq 0) 'broken existing Node is not overwritten'
Reset-Scenario; $script:version='v20.1.0'
$result=Invoke-ProjectSetup
Assert-Test ($result -eq 1 -and $script:installs -eq 0) 'unsupported Node is not overwritten'
Reset-Scenario; $script:extensions=@('dbaeumer.vscode-eslint')
$result=Invoke-ProjectSetup
Assert-Test ($result -eq 0 -and $script:installs -eq 1) 'only the missing extension is installed'
$result=Invoke-ProjectSetup
Assert-Test ($result -eq 0 -and $script:installs -eq 1) 'rerunning does not reinstall extensions'
Reset-Scenario; $script:extensions=@()
$result=Invoke-ProjectSetup -CheckOnly
Assert-Test ($result -eq 1 -and $script:installs -eq 0) 'check-only does not install extensions'
Write-Host "$script:passed Windows behavior checks passed."
exit 0
