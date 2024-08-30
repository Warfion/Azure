try
{
    "Logging in to Azure..."
    Connect-AzAccount -Identity
}
catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}

$TagName = "Remote Control"
$TagValue = "true"

$VMs = Get-AzResource -TagName $TagName -TagValue $TagValue | Where-Object -FilterScript {$_.ResourceType -like 'Microsoft.Compute/virtualMachines'}

foreach ($VM in $VMs) {
Stop-AzVM -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name -Force -Verbose
}
