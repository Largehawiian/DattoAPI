# DattoAPI
Powershell module for Datto API interaction

#### Installation
    Install-Module Datto-API
    Import-Module Datto-API

#### Usage
    $Token = New-DattoAPIToken -APIKey "1234567" -APISecretKey "asdfasdfasdf"

    $Sites = Get-DattoSites -APIToken $Token

    $SiteDevices = Get-DattoDevices -APIKey $Token -SiteUID $SiteUID

#### Get All Devices

    $AllDevices = Get-DattoSites -APIKey $Token | Get-DattoDevices -APIKey $Token
