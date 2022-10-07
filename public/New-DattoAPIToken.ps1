<#
.SYNOPSIS
    Requests a new Datto API token.
.DESCRIPTION
    Requests a new Datto API token. Requires a valid Datto API key and secret.
.NOTES
    
.LINK
    https://concord-api.centrastage.net/api/swagger-ui/index.html#//v3
.EXAMPLE
    New-DattoAPIToken -APIKey "1234567890" -APISecret "1234567890"
#>
function New-DattoAPIToken {
	param (
		[string]$apiKey,
		[string]$apiSecretKey,
		[string]$platform
	)
	$Form = @{
		Credential = [System.Management.automation.PSCredential]::new('public-client', (ConvertTo-SecureString -String 'public' -AsPlainText -Force))
		Body       = 'grant_type=password&username={0}&password={1}' -f $apiKey, $apiSecretKey
	}
	if ($Platform.Length -gt 0) {
		
		$Return = Invoke-RestMethod  -Uri ("https://{0}-api.centrastage.net/auth/oauth/token" -f $Platform) -Method POST -ContentType 'application/x-www-form-urlencoded' -Body $Form.Body -Credential $Form.Credential
	}
	else { 
		$Return = Invoke-RestMethod  -Uri "https://concord-api.centrastage.net/auth/oauth/token" -Method POST -ContentType 'application/x-www-form-urlencoded' -Body $Form.Body -Credential $Form.Credential
	}
	
	$Return.access_token
}
