<#
  gitwho.ps1 – Git Author Switcher (stable)
#>

param(
    [Parameter(Position=0)][string]$Profile,
    [switch]$List
)

$ErrorActionPreference = 'Stop'

# ── Settings ──────────────────────────────────────────────────────
$StorePath   = "$env:PROGRAMDATA\git-who\profiles.json"
$BrandColor  = 'Cyan'
$ActiveColor = 'Green'
# -----------------------------------------------------------------

function Brand($msg){ Write-Host $msg -ForegroundColor $BrandColor }
function Pause(){ Read-Host 'Press ENTER to continue' | Out-Null }

function Load-Profiles {
    if (-not (Test-Path $StorePath)) {
        New-Item -ItemType Directory (Split-Path $StorePath) -EA 0 | Out-Null
        return @{}
    }
    (Get-Content $StorePath -Raw) | ConvertFrom-Json
}

function Save-Profiles($obj){
    $obj | ConvertTo-Json -Depth 3 | Set-Content -Encoding UTF8 $StorePath
}

function CurrentAuthor {
    [pscustomobject]@{
        Name  = git config --global user.name  2>$null
        Email = git config --global user.email 2>$null
    }
}

function Set-Author($name,$email){
    git config --global user.name  $name
    git config --global user.email $email
    Write-Host "`nAuthor set to: $name <$email>" -ForegroundColor $ActiveColor
}

function List-Profiles($profiles,$cur){
    if (-not $profiles.PSObject.Properties.Count) {
        Write-Host '(no profiles)' -ForegroundColor Red
        return @{}
    }
    $map=@{}; $i=0
    foreach ($k in ($profiles.PSObject.Properties.Name | Sort-Object)) {
        $i++; $map[$i]=$k
        $p=$profiles.$k
        $star = if ($p.name -eq $cur.Name -and $p.email -eq $cur.Email) { '*' } else { ' ' }
        $fg   = if ($star -eq '*') { $ActiveColor } else { 'Yellow' }
        Write-Host (" {0}[{1}] {2} <{3}>" -f $star,$i,$p.name,$p.email) -ForegroundColor $fg
    }
    return $map
}

# ── Main ─────────────────────────────────────────────────────────
$Profiles = Load-Profiles
$Current  = CurrentAuthor

if ($List) { List-Profiles $Profiles $Current | Out-Null; exit }

# Fast switch by key argument
if ($Profile) {
    if (-not $Profiles.PSObject.Properties[$Profile]) {
        Write-Host "Profile '$Profile' not found" -ForegroundColor Red; exit 1 }
    $p=$Profiles.$Profile; Set-Author $p.name $p.email; exit
}

while ($true) {
    Clear-Host
    Brand '=== gitwho : Git Author Switcher ==='
    if (-not $Current.Name) { Write-Host '(author not set)' -ForegroundColor DarkGray }
    $idx = List-Profiles $Profiles $Current
    Brand '(S)elect  (A)dd  (Q)uit : '
    $choice = (Read-Host).ToUpper()

    switch ($choice) {
        'S' {
            if (-not $Profiles.PSObject.Properties.Count) { Pause; break }
            $num = [int](Read-Host 'Profile number')
            $key = $idx[$num]
            if (-not $key) { Write-Host 'Invalid selection' -ForegroundColor Red; Pause; break }
            $sel = $Profiles.$key; Set-Author $sel.name $sel.email; Pause; break
        }
        'A' {
            $key = Read-Host 'Key (no spaces)'; if (-not $key) { Pause; break }
            if ($Profiles.PSObject.Properties[$key]) { Write-Host 'Key exists' -ForegroundColor Red; Pause; break }
            $name  = Read-Host 'Display name'
            $email = Read-Host 'Email'
            if (-not $name -or -not $email) { Write-Host 'Both required' -ForegroundColor Red; Pause; break }
            $Profiles | Add-Member -MemberType NoteProperty -Name $key -Value @{name=$name;email=$email} -Force
            Save-Profiles $Profiles
            Write-Host 'Saved.' -ForegroundColor Green; Pause; break
        }
        'Q' { exit }
    }
    $Current = CurrentAuthor
}
