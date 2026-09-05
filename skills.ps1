[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$AllArgs
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
& "$scriptDir\my-skills.ps1" @AllArgs