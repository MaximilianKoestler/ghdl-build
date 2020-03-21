Function Install-MingwPath {
    $MingwBase = "$(Get-Location)\build\mingw"
    $Env:Path = ""
    $Env:Path += ";$MingwBase\bin"
    $Env:Path += ";$MingwBase\msys\1.0\bin"
    Write-Host $env:Path
}

Function Invoke-Configure($Prefix) {
    & "sh" configure --prefix=$Prefix
}

Function Invoke-Make {
    & "make"
}

Function Main() {
    $BaseDir = Get-Location
    $OriginalPath = $Env:Path

    Install-MingwPath

    Push-Location "build\ghdl"
    Invoke-Configure "$BaseDir\dist"
    # Invoke-Make
    Pop-Location

    $Env:Path = $OriginalPath
}

Main
