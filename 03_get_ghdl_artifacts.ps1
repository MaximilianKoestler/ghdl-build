Function Get-AppveyorToken {
    if (Test-Path Env:AppveyorToken) {
        return $Env:AppveyorToken
    } else {
        Throw "No AppVeyor token provided!"
    }
}

Function Get-Artifacts {
    $ApiUrl = "https://ci.appveyor.com/api"
    $Token = Get-AppveyorToken

    $Headers = @{
        "Authorization" = "Bearer $Token"
        "Content-type" = "application/json"
    }
    $AccountName = "tgingold"
    $ProjectSlug = "ghdl-psgys"

    $Project = Invoke-RestMethod -Method Get -Uri "$ApiUrl/projects/$AccountName/$ProjectSlug" -Headers $Headers

    $Jobs = $Project.build.jobs
    $Job = $Jobs | Where-Object {$_.name -eq "Environment: BUILD_MINGW=mingw32, BUILD_BACKEND=mcode"}
    if( $Job -eq $null )
    {
        Throw "No job with matching name found!"
    }
    $JobId = $Job.jobId

    $Artifacts = Invoke-RestMethod -Method Get -Uri "$ApiUrl/buildjobs/$JobId/artifacts" -Headers $Headers
    $ArtifactFileName = $Artifacts[0].fileName

    $LocalArtifactPath = "build\$ArtifactFileName"
    Invoke-RestMethod -Method Get -Uri "$ApiUrl/buildjobs/$JobId/artifacts/$ArtifactFileName" -OutFile $LocalArtifactPath -Headers @{ "Authorization" = "Bearer $Token" }

    return $LocalArtifactPath
}

Function Expand-Artifacts($Artifacts) {
    $Destination = "build\ghdl_artifacts"
    Expand-Archive -LiteralPath $artifacts -DestinationPath $Destination

    # fix directory layout
    $ExtractedName = Get-ChildItem -Path "$Destination\GHDL" -Name | Select-Object -first 1
    Move-Item "$Destination\GHDL\$ExtractedName\*" $Destination
    Remove-Item "$Destination\GHDL\$ExtractedName"
    Remove-Item "$Destination\GHDL"
}

Function Main() {
    $artifacts = Get-Artifacts
    $Artifacts = "build\ghdl-master-1039-mingw32-mcode.zip"
    Expand-Artifacts $Artifacts
}

Main
