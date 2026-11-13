[CmdletBinding()]
param([switch]$CheckOnly)

function Find-CourseTool([string]$Name) {
    $command = Get-Command $Name -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($command) { return $command.Source }
    $known = switch ($Name) {
        'git.exe' { @("$env:ProgramFiles\Git\cmd\git.exe", "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe") }
        'node.exe' { @("$env:ProgramFiles\nodejs\node.exe", "$env:LOCALAPPDATA\Programs\nodejs\node.exe") }
        'npm.cmd' { @("$env:ProgramFiles\nodejs\npm.cmd", "$env:LOCALAPPDATA\Programs\nodejs\npm.cmd") }
        'code.cmd' { @("$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd", "$env:ProgramFiles\Microsoft VS Code\bin\code.cmd") }
    }
    foreach ($file in $known) { if (Test-Path -LiteralPath $file -PathType Leaf) { return $file } }
    return $null
}

function Read-CourseVersion([string]$File) {
    $value = @(& $File --version 2>&1) -join ' '
    if ($LASTEXITCODE -ne 0) { throw 'An existing tool could not start. Keep it and use Setup Help before reinstalling.' }
    return $value.Trim()
}

function Test-CourseNode([string]$Version, [datetime]$Today = (Get-Date)) {
    if ($Version -notmatch '^v(\d+)\.\d+\.\d+$') { return $false }
    $support = @{
        '22' = @('2024-10-29', '2027-04-30')
        '24' = @('2025-10-28', '2028-04-30')
        '26' = @('2026-10-28', '2029-04-30')
    }
    $period = $support[$Matches[1]]
    return ($period -and $Today -ge [datetime]$period[0] -and $Today -lt [datetime]$period[1])
}

function Test-NodeManager {
    foreach ($folder in @($env:NVM_HOME, $env:FNM_DIR, $env:VOLTA_HOME, "$env:LOCALAPPDATA\fnm", "$env:LOCALAPPDATA\Volta", "$env:APPDATA\nvm")) {
        if ($folder -and (Test-Path -LiteralPath $folder)) { return $true }
    }
    foreach ($name in @('nvm.exe','fnm.exe','volta.exe')) {
        if (Get-Command $name -ErrorAction SilentlyContinue) { return $true }
    }
    return $false
}

function Install-MissingGit {
    $winget = Get-Command winget.exe -ErrorAction SilentlyContinue
    if (-not $winget) { throw 'Git is missing and Windows App Installer is unavailable. Use the manual Git steps in Setup Help.' }
    $log = Join-Path $env:TEMP ('itm325-git-' + [guid]::NewGuid().ToString('N') + '.log')
    Write-Host 'Installing missing Git. Review any Windows permission prompt.'
    Write-Host "Installation details are saved here: $log"
    # Keep translated installer output in the log. Do not hide interactive agreements.
    $saved = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        & $winget.Source install --id Git.Git --exact --source winget --silent --no-upgrade --disable-interactivity 2>&1 | Out-File -LiteralPath $log -Encoding UTF8
        $status = $LASTEXITCODE
    } finally { $ErrorActionPreference = $saved }
    if ($status -ne 0) { throw 'Git installation needs attention. Use the manual Git steps in Setup Help, then rerun this helper.' }
}

function Install-MissingNode {
    if (-not (Test-CourseNode 'v24.0.0')) { throw 'This course installer needs a newer LTS configuration. Use Setup Help.' }
    if (Test-NodeManager) { throw 'A Node version manager was found. Use that manager to activate Node. See Setup Help; no second installation was added.' }
    $arch = if ($env:PROCESSOR_ARCHITEW6432) { $env:PROCESSOR_ARCHITEW6432 } else { $env:PROCESSOR_ARCHITECTURE }
    $arch = switch ($arch.ToUpperInvariant()) { 'AMD64' { 'x64' }; 'ARM64' { 'arm64' }; default { throw 'This installer supports x64 and ARM64 Windows. Use Setup Help.' } }
    $base = 'https://nodejs.org/dist/latest-v24.x/'
    $manifest = (Invoke-WebRequest -UseBasicParsing -Uri ($base + 'SHASUMS256.txt') -TimeoutSec 45).Content
    $line = @($manifest -split "`n" | Where-Object { $_ -match "^[a-f0-9]{64}\s+node-v24\.\d+\.\d+-$arch\.msi\s*$" })
    if ($line.Count -ne 1) { throw 'The official Node installer could not be identified. Use Setup Help.' }
    $parts = $line[0].Trim() -split '\s+'
    $folder = Join-Path $env:TEMP ('itm325-node-' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $folder | Out-Null
    $file = Join-Path $folder $parts[1]
    Write-Host 'Downloading Node.js 24 LTS from nodejs.org. This may take a few minutes.'
    Invoke-WebRequest -UseBasicParsing -Uri ($base + $parts[1]) -OutFile $file -TimeoutSec 300
    if ((Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash -ne $parts[0]) { throw 'The Node download did not pass its checksum. Nothing was installed. Rerun the helper.' }
    if ((Get-AuthenticodeSignature -LiteralPath $file).Status -ne 'Valid') { throw 'Windows could not verify the Node installer signature. Use Setup Help.' }
    Write-Host 'Complete the Node installer. Keep npm and Add to PATH selected.'
    Write-Host 'Leave the optional Tools for Native Modules checkbox unchecked.'
    $process = Start-Process -FilePath 'msiexec.exe' -ArgumentList @('/i', ('"' + $file + '"'), '/norestart') -Wait -PassThru
    if ($process.ExitCode -eq 3010) { throw 'Windows requested a restart. Save your work, restart, and rerun this helper.' }
    if ($process.ExitCode -ne 0) { throw 'The Node installer did not finish. Rerun this helper after resolving the installer message.' }
}

function Invoke-ProjectSetup([switch]$CheckOnly) {
    $savedPreference = $ErrorActionPreference
    $savedProgress = $ProgressPreference
    $savedProtocol = [Net.ServicePointManager]::SecurityProtocol
    try {
        $ErrorActionPreference = 'Stop'
        $ProgressPreference = 'SilentlyContinue'
        [Net.ServicePointManager]::SecurityProtocol = $savedProtocol -bor [Net.SecurityProtocolType]::Tls12
        if ([Environment]::OSVersion.Platform -ne [PlatformID]::Win32NT -or -not [Environment]::Is64BitProcess) { throw 'Use 64-bit Windows PowerShell or PowerShell 7 on Windows.' }
        $code = Find-CourseTool 'code.cmd'
        if (-not $code) { throw 'VS Code was not found. Complete the first setup or use Setup Help for a custom installation.' }
        Write-Host 'ITM 325 | Project tools'
        if (-not $CheckOnly) {
            Write-Host 'Keep working tools. Install only missing Git and Node.js, including npm.'
            $answer = Read-Host 'Type Y to continue, or press Enter to stop'
            if ($answer -notmatch '^(?i)y(es)?$') { Write-Host 'Stopped. No installation changes were made.'; return 3 }
        }
        $git = Find-CourseTool 'git.exe'
        if (-not $git) {
            if ($CheckOnly) { throw 'Git is missing.' }
            Install-MissingGit
            $git = Find-CourseTool 'git.exe'
        }
        if (-not $git) { throw 'Git was not found. Reopen VS Code or use Setup Help.' }
        $gitVersion = Read-CourseVersion $git
        if ($gitVersion -notmatch '^git version ') { throw 'The Git command returned an unexpected result. Use Setup Help.' }
        Write-Host "KEEP: $gitVersion"
        $node = Find-CourseTool 'node.exe'
        if (-not $node) {
            if (Find-CourseTool 'npm.cmd') { throw 'npm exists but Node was not found. Use Setup Help before adding another installation.' }
            if ($CheckOnly) { throw 'Node.js is missing.' }
            Install-MissingNode
            $node = Find-CourseTool 'node.exe'
        }
        if (-not $node) { throw 'Node was not found after installation. Reopen VS Code and rerun this helper.' }
        $nodeVersion = Read-CourseVersion $node
        if (-not (Test-CourseNode $nodeVersion)) { throw "Node $nodeVersion is outside the supported LTS versions checked by this course helper. Keep the installation and use Node.js help to select an LTS version." }
        # Refresh this process only; never replace the student's saved PATH or version manager.
        $env:Path = (Split-Path -Parent $node) + ';' + $env:Path
        $npm = Find-CourseTool 'npm.cmd'
        if (-not $npm) { throw 'Node exists but npm was not found. Use Setup Help before reinstalling.' }
        $npmVersion = Read-CourseVersion $npm
        if ($npmVersion -notmatch '^\d+\.\d+\.\d+') { throw 'npm returned an unexpected version. Use Setup Help.' }
        Write-Host "KEEP: Node $nodeVersion and npm $npmVersion"
        Write-Host 'PROJECT TOOLS READY'
        Write-Host 'Reopen all VS Code windows and use a new terminal for the final checks in the guide.'
        return 0
    } catch {
        Write-Host 'SETUP NEEDS ATTENTION'
        Write-Host $_.Exception.Message
        Write-Host 'Help: https://github.com/cyj-oss/itm325-setup2/blob/main/HELP.md'
        return 1
    } finally {
        $ErrorActionPreference = $savedPreference
        $ProgressPreference = $savedProgress
        [Net.ServicePointManager]::SecurityProtocol = $savedProtocol
    }
}

if ($MyInvocation.InvocationName -ne '.') { $global:LASTEXITCODE = Invoke-ProjectSetup -CheckOnly:$CheckOnly }
