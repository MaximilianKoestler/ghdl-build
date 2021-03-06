Function Get-PythonLocation {
    if (Test-Path Env:GhdlPythonPath) {
        return $Env:GhdlPythonPath
    } else {
        # see https://github.com/actions/virtual-environments/blob/master/images/win/Windows2019-Readme.md
        return "C:\hostedtoolcache\windows\Python\3.7.8\x86"
    }
}

Function Install-Venv($Python) {
    & "$Python\python.exe" -m venv build\python
    & "build\python\Scripts\python.exe" -m pip install --upgrade pip
    & "build\python\Scripts\python.exe" -m pip install PyInstaller
}

Function Main() {
    $GhdlPythonPath = Get-PythonLocation

    Install-Venv($GhdlPythonPath)
}

Main
