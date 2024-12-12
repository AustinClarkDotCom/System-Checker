# cpu usage
Write-Host "cpu Usage: $(Get-WmiObject -Class Win32_Processor | ForEach-Object { $_.LoadPercentage })%"

# memory usage
$memory = Get-WmiObject -Class Win32_OperatingSystem
$totalMemory = [math]::Round($memory.TotalVisibleMemorySize / 1MB, 2)
$freeMemory = [math]::Round($memory.FreePhysicalMemory / 1MB, 2)
Write-Host "Memory: Total: $totalMemory MB, Free: $freeMemory MB"

# disk space
Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
    $totalSpace = [math]::Round($_.Size / 1GB, 2)
    $freeSpace = [math]::Round($_.FreeSpace / 1GB, 2)
    Write-Host "Drive $($_.DeviceID): Total: $totalSpace GB, Free: $freeSpace GB"
}

# network connection test
if (Test-Connection -ComputerName google.com -Count 1 -Quiet) {
    Write-Host "you are connected"
} else {
    Write-Host "you are disconnected"
}

# Run System File Checker
Write-Host "Running System File Checker:"
sfc /scannow

Write-Host "System Health Check Completed."