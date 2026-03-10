@{
    ModuleVersion = '1.0.0'
    CompatiblePSEditions = @('Desktop')
    PowerShellVersion = '5.1'
    Author = 'Valorisa'
    Description = 'GPP Event 4117 Monitor - Windows 11/Server 2025 diagnostics'
    FunctionsToExport = @('Get-GPP4117')
    RootModule = 'src/public/Get-GPP4117.psm1'
}
