class DattoDevice {
	[String]$Endpoint
	[String]$IPAddress
	[String]$OperatingSystem
    [String]$SiteName
    [String]$DeviceType
    [String]$LastLoggedInUser

	DattoDevice () {}

	DattoDevice ([String]$Endpoint, [String]$IPAddress, [String]$OperatingSystem, [String]$SiteName, [String]$DeviceType, [String]$LastLoggedInUser) {
		$this.Endpoint = $Endpoint
		$this.IPAddress = $IPAddress
		$this.OperatingSystem = $OperatingSystem
        $this.SiteName = $SiteName
        $this.DeviceType = $DeviceType
        $this.LastLoggedInUser = $LastLoggedInUser
	}

	static [pscustomobject]ToCSV ([Array]$InputObject){
		$obj = $Inputobject | ForEach-Object {
			[PSCustomObject]@{
                SiteName = $_.SiteName
				Endpoint = $_.hostname
                DeviceType = $_.deviceType.category
				IPAddress = $_.intIpAddress
				OperatingSystem = $_.OperatingSystem
                LastLoggedInUser = $_.LastLoggedInUser
			}
		}
		return $Obj | ConvertTo-Csv -NoTypeInformation
	}
	static [pscustomobject]ToReport ([Array]$InputObject){
		return $InputObject | ForEach-Object {
			[DattoDevice]::New(
				$_.hostname,
				$_.intIpAddress,
				$_.OperatingSystem,
				$_.SiteName,
				$_.deviceType.category,
				$_.LastLoggedInUser
			)
		}
	}
}