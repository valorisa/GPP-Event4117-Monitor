# GPP Event 4117 Monitor 
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1-blue)](https://github.com/PowerShell/PowerShell)
[![License](https://img.shields.io/github/license/valorisa/GPP-Event4117-Monitor)](LICENSE)

**PowerShell 5.1 module** qui monitore les **Event ID 4117** (diagnostics GPP Windows 11 24H2+/Server 2025).  
*53+ events détectés en home lab !*

## 🚀 Quickstart (5s)
`powershell
Import-Module .\GPP-Event4117-Monitor.psd1
Get-GPP4117 -HoursBack 24
`

## 📊 Event ID supportés
| Event ID | Niveau | Contexte |
|----------|--------|----------|
| 4096 | Info | GPP OK ✅ |
| **4098** | ⚠️ | Échec générique |
| 4105 | ⚠️ | Targeting échoué |
| **4117** | ⚠️ | **Détaillé 2026** ✨ |

## 💻 Usage
`powershell
Get-GPP4117 -HoursBack 24                    # Tableau
Get-GPP4117 -HoursBack 24 -Output json       # JSON
Get-GPP4117 -DaysBack 7 -Output csv          # CSV
`

## 📈 Stats réelles
- **53 Event 4117** détectés
- **PowerShell 5.1** natif
- **Zero dépendances**

## 📄 License
MIT © Valorisa 2026
