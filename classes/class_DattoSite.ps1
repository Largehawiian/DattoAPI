class DattoSite {
    [String]$id
    [String]$siteUID
    [String]$Name
    [String]$TotalDevices
    [String]$DevicesOnline
    [String]$DevicesOffline


    DattoSite () {}

    DattoSite ([String]$id, [String]$siteUID, [String]$Name, [String]$TotalDevices, [String]$DevicesOnline, [String]$DevicesOffline) {
        $this.id = $id
        $this.siteUID = $siteUID
        $this.Name = $Name
        $this.TotalDevices = $TotalDevices
        $this.DevicesOnline = $DevicesOnline
        $this.DevicesOffline = $DevicesOffline
    }

    static [pscustomobject]DattoSiteList ($InputObject){
        $Obj =  $InputObject | ForEach-Object {
            [PSCustomObject]@{
                id = $_.id
                siteUID = $_.uid
                Name = $_.name.trim()
                TotalDevices = $_.devicesStatus.NumberOfDevices
                DevicesOnline = $_.devicesStatus.numberOfOnlineDevices
                DevicesOffline = $_.devicesStatus.numberOfOfflineDevices
            }
        }
        return $Obj
    }
}