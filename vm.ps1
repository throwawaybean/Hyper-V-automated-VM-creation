# This script creates a Multiple VM's Based on the Names file you provided.

#Enter the File path which contains the VM names in a separate Lines
$VMName = Get-Content "VM\vm.txt"

#Enter the ISO File path which contains the Windows Installation files
$ISOpath = "VM\iso\q4os-3.14-x64-instcd.r2.iso"

#Path of the VM HDD file stored
$VMLOC = "VM\disk\"
$VMNet = "External"

#Create the VM's
Foreach($vm in $VMName) { New-VM -Name $VM -Generation 1 -SwitchName "$VMNet"
 New-VHD -Path "$VMLOC\$vm.vhdx" -SizeBytes 10GB
 ADD-VMHardDiskDrive -VMName $vm -Path "$VMLOC\$vm.vhdx"
 Set-VM -ProcessorCount 4 $VM -MemoryStartupBytes 1GB
 Set-VMDvdDrive -VMName $vm -Path $ISOpath
 Set-VM -Name $vm -AutomaticStartAction Nothing -AutomaticStopAction TurnOff
 Enable-VMIntegrationService -VMName $vm -Name "Guest Service Interface"
}

# Fire it up 🔥
Start-VM $vmname