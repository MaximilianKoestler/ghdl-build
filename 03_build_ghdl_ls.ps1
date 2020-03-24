Function Install-MingwPath {
    $MingwBase = "$(Get-Location)\build\mingw"
    $Env:Path = ""
    $Env:Path += ";$MingwBase\bin"
    $Env:Path += ";$MingwBase\msys\1.0\bin"
    Write-Host $env:Path
}

Function Invoke-Pip {
    # ...
}

Function Main() {
    $BaseDir = Get-Location
    $OriginalPath = $Env:Path

    Install-MingwPath

    Push-Location "build\ghdl"
    Invoke-Pip
    Pop-Location

    $Env:Path = $OriginalPath
}

Main
