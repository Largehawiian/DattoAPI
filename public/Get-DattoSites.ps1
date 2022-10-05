<#
.SYNOPSIS
    Return a list of Datto Sites.
.DESCRIPTION
    Return a list of Datto Sites for an account.
.NOTES
    
.LINK
    https://concord-api.centrastage.net/api/swagger-ui/index.html#//v3
.EXAMPLE
    Get-DattoSites -APIToken $AEMToken
#>
function Get-DattoSites {
	param (
		[parameter(Mandatory=$true)][string]$APIToken
	)
	$Results = [System.Collections.Generic.List[array]]::new()
	$URI = [System.UriBuilder]::new()
	$URI.Host = ("concord-api.centrastage.net/api/v2/account/sites")
	$URI.Scheme = "https"
	$DeviceHeaders = @{
		"Authorization" = "Bearer $AEMToken"
	}
	$o = Invoke-RestMethod -Method GET -ContentType "application/json" -Uri $URI.Uri.AbsoluteUri -Headers $Headers
	$Results.Add($o.Sites)
	if ($o.pageDetails.nextPageUrl.Length -gt 0 ){
		do {
			$x = Invoke-RestMethod -Method GET -ContentType "application/json" -Uri $DeviceObj.pageDetails.nextPageUrl -Headers $DeviceHeaders
			$Results.Add($x.Sites)
		} while ($x.pageDetails.nextPageUrl.Length -gt 0)
	}
	$Return = @()
	$Results | ForEach-Object { $Return += $_ }
    $obj = [DattoSite]::DattoSiteList($return)
	return $obj
}