$BuildDir = "$PSScriptRoot\build"

Function Checkpoint-Extension {
    Copy-Item -Path "$BuildDir\ghdl-language-server\vscode-client\extension.ts" -Destination "extension.backup.ts"
}

Function Edit-Extension {
    Push-Location $PSScriptRoot
    git apply extension.ts.patch
    Pop-Location
}

Function Restore-Extension {
    Move-Item -Path "extension.backup.ts" -Force -Destination "$BuildDir\ghdl-language-server\vscode-client\extension.ts"
}

Function Add-Binaries {
    Remove-Item -Path "$BuildDir\ghdl-language-server\vscode-client\bin" -Recurse -Force -ErrorAction Ignore;
    Copy-Item -Path "$BuildDir\pyinstaller\dist\ghdl-ls" -Recurse -Destination "$BuildDir\ghdl-language-server\vscode-client\bin"
}

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
    Checkpoint-Extension
    Edit-Extension
    Add-Binaries

    Push-Location "$BuildDir\ghdl-language-server\vscode-client"
    Install-Modules
    Invoke-Vsce
    Pop-Location

    Restore-Extension
}

Main
