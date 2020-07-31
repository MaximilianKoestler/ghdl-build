$BuildDir = "$PSScriptRoot\build"

Function Get-Repository($Location, $Destination) {
    $Url = "https://api.github.com/repos/$Location/tarball/master"
    Write-Host "Downloading and extracting from $Url to $Destination"

    # cleanup
    Remove-Item -Recurse -Force $Destination -ErrorAction Ignore
    New-Item -Path $Destination -ItemType "directory" | Out-Null

    # download and extract
    $DownloadLocation = New-TemporaryFile
    Invoke-WebRequest -Uri $Url -OutFile $DownloadLocation
    tar -xzf $DownloadLocation -C $Destination

    # fix directory layout
    $extractedName = Get-ChildItem -Path $Destination -Name | Select-Object -first 1
    Move-Item "$Destination\$extractedName\*" $Destination
    Remove-Item "$Destination\$extractedName"
}

Function Main() {
    Get-Repository "ghdl/ghdl" "$BuildDir\ghdl"
    Get-Repository "ghdl/ghdl-language-server" "$BuildDir\ghdl-language-server"
}

Main
