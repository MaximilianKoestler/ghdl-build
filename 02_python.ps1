Function Get-PythonLocation {
    if (Test-Path Env:GhdlPythonPath) {
        return $Env:GhdlPythonPath
    } else {
        # see https://github.com/actions/virtual-environments/blob/master/images/win/Windows2019-Readme.md
        return "C:\hostedtoolcache\windows\Python\3.7.6\x86"
    }
}

Function Install-Venv($Python) {
    & "$Python\python.exe" -m venv build\python
}

Function Main() {
    $GhdlPythonPath = Get-PythonLocation

    Install-Venv($GhdlPythonPath)
}

Main
