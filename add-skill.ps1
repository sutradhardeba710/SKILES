[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$Repo,

    [Parameter(Position = 1)]
    [string]$SkillName
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
& "$scriptDir\my-skills.ps1" add $Repo $SkillName