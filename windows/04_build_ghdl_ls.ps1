# see https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#using-a-specific-shell
# GitHub changes the default to $ErrorActionPreference = 'stop'
$ErrorActionPreference = "Continue"

Function Install-MingwPath {
    $MingwBase = "$PSScriptRoot\build\mingw"
    $Env:Path += ";$MingwBase\bin"
    $Env:Path += ";$MingwBase\msys\1.0\bin"
}

Function Install-GhdlPath {
    $GhdlBase = "$PSScriptRoot\build\ghdl_artifacts"
    $Env:Path += ";$GhdlBase\bin"
    $Env:Path += ";$GhdlBase\lib"
}

Function Invoke-Pip($PythonPath) {
    & "$PythonPath\pip" install .
}

Function Main() {
    $BuildDir = Join-Path -Path $PSScriptRoot -ChildPath "build"
    Push-Location "$BuildDir\ghdl\python"
    Invoke-Pip("$BuildDir\python\Scripts\")
    Pop-Location

    $OriginalPath = $Env:Path
    $Env:Path = ""

    Install-MingwPath
    Install-GhdlPath
    Write-Host $Env:Path

    & "$BuildDir\python\Scripts\pyinstaller.exe" "$PSScriptRoot\python\ghdl-ls.spec" `
        --workpath "$BuildDir\pyinstaller\build" `
        --distpath "$BuildDir\pyinstaller\dist"

    # TODO: Test that we can run gldl-ls

    $Env:Path = $OriginalPath
}

Main
