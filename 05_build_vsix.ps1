Function Install-Modules {
    Write-Host "Installing Node modules"

    $LogLevelParam = if ($env:CI) { "--loglevel=error" } else { "" }
    npm install $LogLevelParam
    npm install vsce $LogLevelParam
}

Function Invoke-Vsce {
    Write-Host "Invoking vsce"
    & "node_modules\.bin\vsce" package -o "..\.."
}

Function Main() {
    Push-Location "build\ghdl-language-server\vscode-client"
    Install-Modules
    Invoke-Vsce
    Pop-Location
}

Main
