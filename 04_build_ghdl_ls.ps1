# see https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#using-a-specific-shell
# GitHub changes the default to $ErrorActionPreference = 'stop'
$ErrorActionPreference = "Continue"

Function Install-MingwPath {
    $MingwBase = "$(Get-Location)\build\mingw"
    $Env:Path += ";$MingwBase\bin"
    $Env:Path += ";$MingwBase\msys\1.0\bin"
}

Function Install-GhdlPath {
    $GhdlBase = "$(Get-Location)\build\ghdl_artifacts"
    $Env:Path += ";$GhdlBase\bin"
    $Env:Path += ";$GhdlBase\lib"
}

Function Invoke-Pip($PythonPath) {
    & "$PythonPath\pip" install .
}

Function Main() {
    $BaseDir = Get-Location
    Push-Location "build\ghdl\python"
    Invoke-Pip("$BaseDir\build\python\Scripts\")
    Pop-Location

    $OriginalPath = $Env:Path
    $Env:Path = ""

    Install-MingwPath
    Install-GhdlPath
    Write-Host $Env:Path

    # Test that we can run gldl-ls
    & "build\python\Scripts\pyinstaller.exe" python\ghdl-ls.spec `
        --workpath build\pyinstaller\build `
        --distpath build\pyinstaller\dist

    $Env:Path = $OriginalPath
}

Main
