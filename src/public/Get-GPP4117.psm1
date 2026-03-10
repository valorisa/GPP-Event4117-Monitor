function Get-GPP4117 {
    [CmdletBinding()]
    param(
        [int]$HoursBack = 24,
        [int]$DaysBack,
        [ValidateSet("json","table","csv")][string]$Output = "table"
    )

    $LogName = "Microsoft-Windows-GroupPolicy/Operational"
    $StartTime = if ($DaysBack) { (Get-Date).AddDays(-$DaysBack) }
                 else { (Get-Date).AddHours(-$HoursBack) }

    Write-Host "🔍 Scanning GPP Events ($StartTime → now)..." -ForegroundColor Cyan

    # SOLUTION PS5.1 : Where-Object au lieu de FilterHashtable
    $Events = Get-WinEvent -LogName $LogName -ErrorAction SilentlyContinue | 
               Where-Object { 
                   $_.Id -in @(4098,4105,4117) -and 
                   $_.TimeCreated -ge $StartTime 
               } | Sort TimeCreated

    $Results = foreach ($Event in $Events.Where({$_.Id -eq 4117})) {
        try {
            $Xml = [xml]$Event.ToXml()
            $Data = $Xml.Event.EventData.Data

            [PSCustomObject]@{
                Timestamp = $Event.TimeCreated.ToString("yyyy-MM-dd HH:mm")
                EventID = $Event.Id
                GPPath = if ($Data.Count -gt 0 -and $Data[0]) { ($Data[0] -replace '\\\\\\\\','\\\\') } else { "N/A" }
                ErrorCode = if ($Data.Count -gt 1 -and $Data[1]) { $Data[1] } else { "N/A" }
                ErrorMsg = if ($Data.Count -gt 2 -and $Data[2]) { $Data[2] } else { "N/A" }
                Target = if ($Data.Count -gt 3 -and $Data[3]) { $Data[3] } else { "N/A" }
            }
        }
        catch {
            [PSCustomObject]@{
                Timestamp = $Event.TimeCreated.ToString("yyyy-MM-dd HH:mm")
                EventID = $Event.Id
                GPPath = "XML Parse Error"
                ErrorCode = $_.Exception.Message
                ErrorMsg = "N/A"
                Target = "N/A"
            }
        }
    }

    switch ($Output) {
        "json" { $Results | ConvertTo-Json -Depth 2 }
        "csv" { $Results | Export-Csv -NoTypeInformation "gpp-errors.csv"; "gpp-errors.csv créée" }
        "table" { $Results | Format-Table -AutoSize }
    }
}

