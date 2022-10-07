<#
.SYNOPSIS
    Returns a list of Datto devices for a given site.
.DESCRIPTION
    Returns a list of Datto devices for a given site. Requires a valid AEM token and the site UID.
.NOTES
    https://concord-api.centrastage.net/api/swagger-ui/index.html#//v3
.LINK
    
.EXAMPLE
    Get-DattoDevices -AEMToken $AEMToken -SiteUID "6a716b86-7a49-44dc-bc7f-e3cf1d976bff"
.EXAMPLE
	Get-DattoSites -APIToken | Get-DattoDevices -APIToken $AEMToken
#>
function Get-DattoDevices {
	param (
		[parameter(Mandatory = $true)][string]$APIToken,
		[parameter(Mandatory = $true, ValueFromPipelineByPropertyName)][string]$SiteUID,
		[String]$Platform
	)
	process {
		$Results = [System.Collections.Generic.List[array]]::new()
		$DeviceURI = [System.UriBuilder]::new()
		if ($Platform.Length -gt 0) {
			{
				$DeviceURI.Host = ("{1}-api.centrastage.net/api/v2/site/{0}/devices" -f $SiteUID, $Platform)
			}
			else { $DeviceURI.Host = ("concord-api.centrastage.net/api/v2/site/{0}/devices" -f $SiteUID)
			}
			$DeviceURI.Scheme = "https"
			$DeviceHeaders = @{
				"Authorization" = "Bearer $AEMToken"
			}
			$o = Invoke-RestMethod -Method GET -ContentType "application/json" -Uri $DeviceURI.Uri.AbsoluteUri -Headers $Headers
			$Results.Add($o.Devices)
			if ($o.pageDetails.nextPageUrl.Length -gt 0 ) {
				do {
					$x = Invoke-RestMethod -Method GET -ContentType "application/json" -Uri $DeviceObj.pageDetails.nextPageUrl -Headers $DeviceHeaders
					$Results.Add($x.Devices)
				} while ($x.pageDetails.nextPageUrl.Length -gt 0)
			}
			$Return = @()
			$Results | ForEach-Object { $Return += $_ }
			return [DattoDevice]::ToReport($Return)
		}
	}