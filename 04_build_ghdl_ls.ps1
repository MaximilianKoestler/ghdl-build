Function Install-MingwPath {
    $MingwBase = "$(Get-Location)\build\mingw"
    $Env:Path += ";$MingwBase\bin"
    $Env:Path += ";$MingwBase\msys\1.0\bin"
}

Function Invoke-Pip {
    # ...
}

Function Main() {
    $BaseDir = Get-Location
    $OriginalPath = $Env:Path

    $Env:Path = ""
    Install-MingwPath
    Write-Host $Env:Path

    Push-Location "build\ghdl"
    Invoke-Pip
    Pop-Location

    $Env:Path = $OriginalPath
}

Main
