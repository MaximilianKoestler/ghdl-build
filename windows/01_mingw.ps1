# see https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#using-a-specific-shell
# GitHub changes the default to $ErrorActionPreference = 'stop'
$ErrorActionPreference = "Continue"

$WorkDir = "$PSScriptRoot\build\mingw"

Function Get-Mingw {
    $Url = "https://osdn.net/frs/redir.php?m=dotsrc&f=mingw%2F68260%2Fmingw-get-0.6.3-mingw32-pre-20170905-1-bin.zip"
    Write-Host "Downloading MinGW setup to $WorkDir"

    # cleanup
    Remove-Item -Recurse -Force $WorkDir -ErrorAction Ignore
    New-Item -Path $WorkDir -ItemType "directory" | Out-Null

    # download and extract
    $DownloadLocation = "$(New-TemporaryFile).zip"
    Invoke-WebRequest -Uri $Url -OutFile $DownloadLocation
    Expand-Archive -LiteralPath $DownloadLocation -DestinationPath $WorkDir

    # suppress warnings about missing config
    Copy-Item "$WorkDir\var\lib\mingw-get\data\defaults.xml" "$WorkDir\var\lib\mingw-get\data\profile.xml"
}

Function Update-Mingw {
    & "$WorkDir\bin\mingw-get.exe" update
}

Function Get-MingwPackage($Name) {
    & "$WorkDir\bin\mingw-get.exe" install $Name 2>&1
}

Function Main() {
    Get-Mingw
    Update-Mingw
    Get-MingwPackage "mingw32-libgcc"
    Get-MingwPackage "mingw32-libgnat"
}

Main
