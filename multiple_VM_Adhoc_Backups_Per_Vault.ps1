$vault=Get-AzRecoveryServicesVault -Name "VName" 
Set-AzRecoveryServicesVaultContext -Vault $vault
$endDate = (Get-Date).AddDays(10).ToUniversalTime()
$vmlist = cat /home/user/vmlist.log
foreach ($i in $vmlist)
{ 
$backupcontainer = Get-AzRecoveryServicesBackupContainer -ContainerType "AzureVM" -FriendlyName $i -VaultId $vault.ID
$item = Get-AzRecoveryServicesBackupItem -Container $backupcontainer -WorkloadType "AzureVM" -VaultId $vault.ID
Backup-AzRecoveryServicesBackupItem -Item $item -ExpiryDateTimeUTC $endDate
}
