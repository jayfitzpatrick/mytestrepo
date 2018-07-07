

$newvcenter = "ddca-lab-nvc2.continent8.com"
$oldvcenter = "ddca-lab-nvc1.continent8.com"

$newvcdserver = "ddca-lab-nvcd2.continent8.com"
$oldvcdserver = "ddca-lab-nvcd1.continent8.com"

$bridgeheadCluster = "Bridgehead"
$ImportedHostCluster = "Imported-Hosts"
$BridgeheadServer = "172.23.164.81"
$DestinitationCluster = "New Cluster"
$migratinghost = "172.23.164.85"




function connect_management_servers{
Process {

        disconnect-viserver -server * -Confirm:$false
        disconnect-ciserver  -server * -Confirm:$false

               $credentials = Get-VICredentialStoreItem -User 'administrator@vsphere.local' -Host $newvcenter -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
               if (!$credentials){
                                        $credentials = Read-host -Prompt "Enter administrator@vsphere.local Password for $newvcenter" -AsSecureString
                                        $credentials = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credentials))
                                        New-VICredentialStoreItem -Host $vcenter -User 'administrator@vsphere.local' -Password $credentials -file C:\scripts\"$env:UserName"-vcenter_passwordfile.txt
                                        $credentials = Get-VICredentialStoreItem -User 'administrator@vsphere.local' -Host $newvcenter -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
                                                                                }
               Connect-VIServer $newvcenter -user administrator@vsphere.local -Password "$credentials"
               Remove-Variable credentials

               $credentials = Get-VICredentialStoreItem -User 'administrator' -Host $newvcdserver -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
               if (!$credentials){
                                        $credentials = Read-host -Prompt "Enter Administrator Password for $newvcdserver" -AsSecureString
                                        $credentials = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credentials))
                                        New-VICredentialStoreItem -Host $newvcdserver -User 'administrator' -Password $credentials -file C:\scripts\"$env:UserName"-vcenter_passwordfile.txt
                                        $credentials = Get-VICredentialStoreItem -User 'administrator' -Host $newvcdserver -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
                                                                                }
               Connect-CIServer $newvcdserver -user administrator -Password "$credentials"
               Remove-Variable credentials

               $credentials = Get-VICredentialStoreItem -User 'administrator@vsphere.local' -Host $oldvcenter -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
               if (!$credentials){
                                        $credentials = Read-host -Prompt "Enter administrator@vsphere.local Password for $oldvcenter" -AsSecureString
                                        $credentials = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credentials))
                                        New-VICredentialStoreItem -Host $oldvcenter -User 'administrator@vsphere.local' -Password $credentials -file C:\scripts\"$env:UserName"-vcenter_passwordfile.txt
                                        $credentials = Get-VICredentialStoreItem -User 'administrator@vsphere.local' -Host $oldvcenter -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
                                                                                }
               Connect-VIServer $oldvcenter -user administrator@vsphere.local -Password "$credentials"
               Remove-Variable credentials

               $credentials = Get-VICredentialStoreItem -User 'administrator' -Host $oldvcdserver -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
               if (!$credentials){
                                        $credentials = Read-host -Prompt "Enter Administrator Password for $oldvcdserver" -AsSecureString
                                        $credentials = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credentials))
                                        New-VICredentialStoreItem -Host $oldvcdserver -User 'administrator' -Password $credentials -file C:\scripts\"$env:UserName"-vcenter_passwordfile.txt
                                        $credentials = Get-VICredentialStoreItem -User 'administrator' -Host $oldvcdserver -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
                                                                                }
               Connect-CIServer $oldvcdserver -user 'administrator' -Password "$credentials"
               Remove-Variable credentials
               }
       }

function connect_new_Management_servers{
Process {

        disconnect-viserver -server * -Confirm:$false
        disconnect-ciserver  -server * -Confirm:$false

               $credentials = Get-VICredentialStoreItem -User 'administrator@vsphere.local' -Host $newvcenter -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
               if (!$credentials){
                                        $credentials = Read-host -Prompt "Enter administrator@vsphere.local Password for $newvcenter" -AsSecureString
                                        $credentials = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credentials))
                                        New-VICredentialStoreItem -Host $vcenter -User 'administrator@vsphere.local' -Password $credentials -file C:\scripts\"$env:UserName"-vcenter_passwordfile.txt
                                        $credentials = Get-VICredentialStoreItem -User 'administrator@vsphere.local' -Host $newvcenter -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
                                                                                }
               Connect-VIServer $newvcenter -user administrator@vsphere.local -Password "$credentials"
               Remove-Variable credentials

               $credentials = Get-VICredentialStoreItem -User 'administrator' -Host $newvcdserver -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
               if (!$credentials){
                                        $credentials = Read-host -Prompt "Enter Administrator Password for $newvcdserver" -AsSecureString
                                        $credentials = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credentials))
                                        New-VICredentialStoreItem -Host $newvcdserver -User 'administrator' -Password $credentials -file C:\scripts\"$env:UserName"-vcenter_passwordfile.txt
                                        $credentials = Get-VICredentialStoreItem -User 'administrator' -Host $newvcdserver -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
                                                                                }
               Connect-CIServer $newvcdserver -user administrator -Password "$credentials"
               Remove-Variable credentials

               }
       }


Function Disable-CIHost {
      Param (
            $CIHost
      )
      Process {
            # Locate the vCloud Director Host
            $search = Search-cloud -QueryType Host -Name $CIHost
            $HostView = Get-CIView -SearchResult $search

            # Disable in vCloud Director
            if ($HostView.Enabled) {
                $DisabledHost = $HostView.Disable()
            }

            # Set VMHost into Maint Mode  Disabled, not needed
           # $MaintenanceHost = Set-VMHost -State Maintenance -VMHost $CIHost | Out-Null

            $HostView = Get-CIView -SearchResult $search
            $HostView
      }
}

Function Enable-CIHost {
 Param (
 $CIHost
 )
 Process {
 $Search = Search-cloud -QueryType Host -Name $CIHost
 #$HostEXT = $search.ExtensionData
 $HostEXT = $search | Get-CIView

 # Disable the host in vCloud Director
 if ($HostEXT.Disable) {
 $HostEXT.Enable()
 }
 }
}

Function Prepare-CIHost {
    Param (
        $Username,
        $Password,
        $CIHost
    )
    $Search = Search-cloud -QueryType Host -Name $CIHost
    $HostView = Get-CIView -SearchResult $Search
    $HostView.Prepare($password, $username)
}

Function UnPrepare-CIHost {
    Param (
          $CIHost
    )
    $Search = Search-cloud -QueryType Host -Name $CIHost
    $HostView = Get-CIView -SearchResult $Search
                if ($HostView.Enabled) {
                $DisabledHost = $HostView.Disable()
            }
    $HostView.UnPrepare()
}

Function Create_Virtual_Switches  {
    Param (
          $migratinghost,
          $migratingnic,
          $oldvcenter,
          $BridgeheadServer,
          $Bridgeheadnic,
          $newvcenter

    )
    Process {
    get-vm -Server $oldvcenter -location "$migratinghost" |foreach {
   $networkname =  Get-vm $($_)  -server $oldvcenter| Get-NetworkAdapter |select -expand Networkname|Sort-Object -Property VMID -Unique
#   write-host $networkname
    $dportgroup =  Get-VirtualSwitch | Get-VirtualPortGroup |where Name -eq $networkname | Select Name, @{N="VLANId";E={$_.Extensiondata.Config.DefaultPortCOnfig.Vlan.VlanId}}
    New-VirtualSwitch -Server $oldvcenter -VMHost $migratinghost -Name vSwitch1
    New-VirtualSwitch -Server $newvcenter -VMHost $BridgeheadServer -Name vSwitch1
    $oldvswitch = Get-VirtualSwitch -Server $oldvcenter -VMHost $migratinghost -Name vSwitch1
    $newvswitch = Get-VirtualSwitch -Server $newvcenter -VMHost $BridgeheadServer -Name vSwitch1
    Add-VirtualSwitchPhysicalNetworkAdapter -server $oldvcenter -VirtualSwitch vSwitch1 -VMHostPhysicalNic (Get-VMHostNetworkAdapter -server $oldvcenter -vmhost $migratinghost -Physical -Name "$migratingnic") -Confirm:$false
    Add-VirtualSwitchPhysicalNetworkAdapter -server $newvcenter  -VirtualSwitch vSwitch1 -VMHostPhysicalNic (Get-VMHostNetworkAdapter -server $newvcenter -vmhost $BridgeheadServer -Physical -Name "$Bridgeheadnic") -Confirm:$false
    New-VirtualPortGroup -VirtualSwitch $oldvswitch -Name $networkname.split("_")[-1] -vlanid $dportgroup.VLANId
    New-VirtualPortGroup -VirtualSwitch $newvswitch -Name $networkname.split("_")[-1] -vlanid $dportgroup.VLANId
          }
    }
    }

Function Switch_Guest_to_Vswitch {
 Param (
        $migratinghost,
        $oldvcenter
        )
Process {

    get-vm -Server $oldvcenter -location "$migratinghost" |foreach {
      $networkname =  Get-vm $($_)  | Get-NetworkAdapter |select -expand Networkname|Sort-Object -Property VMID -Unique
      Get-VM $($_) | Get-NetworkAdapter |Sort-Object -Property VMID -Unique| Set-NetworkAdapter -networkname $networkname.split("_")[-1] -Confirm:$false
    }
    }
    }

Function Migrate-ESXi {
Param (
    $migratinghost,
    $ImportedHostCluster,
    $newvcenter
)
Process {
$credentials = Get-VICredentialStoreItem -User 'root' -Host $migratinghost -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
               if (!$credentials){
                                        $credentials = Read-host -Prompt "Enter root Password for $migratinghost" -AsSecureString
                                        $credentials = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credentials))
                                        New-VICredentialStoreItem -Host $migratinghost -User 'root' -Password $credentials -file C:\scripts\"$env:UserName"-vcenter_passwordfile.txt
                                        $credentials = Get-VICredentialStoreItem -User 'root' -Host $migratinghost -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
                                                                                }
Add-VMHost -server $newvcenter -name "$migratinghost" -Location "$ImportedHostCluster"  -Username "root" -Password $credentials -force
write-host "Sleeping for 60 seconds to allow ESXi to stabilize"
Start-Sleep -Seconds 60
}
}

Function Move_guests {
 Param (
        $location,
        $vcenter,
        $destination
        )
Process {

get-vm -server $vcenter -location "$location" | foreach {

dismount-tools -vm $($_.name) -server $vcenter
get-cddrive -VM $($_.name)  -server $vcenter| set-cddrive -NoMedia -Confirm:$false
    Move-VM -VM $($_.name) -destination $destination -server $vcenter

         }
    }
    }

Function Switch_Guests_to_DVS {
 Param (
    $BridgeheadServer,
    $newvcenter
        )
     get-vm -Server $newvcenter -location "$BridgeheadServer" |foreach {
      $networkname = Get-vm $($_.name) -Server $newvcenter -location "$BridgeheadServer"| Get-NetworkAdapter |select -expand Networkname|Sort-Object -Property VMID -Unique
      Get-VM ($_.name) -Server $newvcenter -location "$BridgeheadServer"| Get-NetworkAdapter |Sort-Object -Property VMID -Unique| Set-NetworkAdapter -Portgroup dv_$networkname -Confirm:$false
       }
    }



Connect_management_servers
Disable-CIHost $migratinghost
Create_Virtual_Switches $migratinghost vmnic1 $oldvcenter $BridgeheadServer vmnic1 $newvcenter
Switch_Guest_to_Vswitch $migratinghost $oldvcenter
Migrate-ESXi $migratinghost $ImportedHostCluster $newvcenter
Move_guests $ImportedHostCluster $newvcenter $BridgeheadServer
Switch_Guests_to_DVS $BridgeheadServer $newvcenter
Move_guests $BridgeheadServer $newvcenter $DestinitationCluster








Reset :

move-vm -server $vcenter -VM "SQL Server" -Destination $BridgeheadServer
get-vm  "sql server" -server $vcenter|Get-NetworkAdapter |Sort-Object -Property VMID -Unique| Set-NetworkAdapter -networkname 172.23.164.0 -Confirm:$false
move-vm -server $vcenter -VM "SQL Server" -Destination $migratinghost


 get-vm -server $vcenter -Location $BridgeheadServer |foreach {
 get-vm $($_.name)  -server $vcenter | Get-NetworkAdapter |Sort-Object -Property VMID -Unique| Set-NetworkAdapter -networkname 172.23.164.0 -Confirm:$false
 move-vm -server $vcenter -VM $($_.name) -Destination $migratinghost
 }


# Re-Attach host to old cluster #cant find a command for this one!
#Migrate-ESXi $migratinghost "Default Cluster" $oldvcenter # does not work
Enable-CIHost $migratinghost

 get-vm -server $oldvcenter -Location $migratinghost |foreach {
 get-vm $($_.name)  -server $vcenter | Get-NetworkAdapter |Sort-Object -Property VMID -Unique| Set-NetworkAdapter -networkname dv_172.23.164.0 -Confirm:$false
# move-vm -server $vcenter -VM $($_.name) -Destination $migratinghost
 }

 get-vm -server $oldvcenter -Location $migratinghost |foreach {get-vm | Get-NetworkAdapter |Sort-Object -Property VMID -Unique| Set-NetworkAdapter -networkname dv_172.23.164.0 -Confirm:$false}
get-vm  "sql server" -server $oldvcenter|Get-NetworkAdapter |Sort-Object -Property VMID -Unique| Set-NetworkAdapter -networkname dv_172.23.164.0 -Confirm:$false
Get-VirtualSwitch -Server $oldvcenter -VMHost $migratinghost -Name vSwitch1 |Remove-VirtualSwitch -Confirm:$false
Get-VirtualSwitch -Server $newvcenter -VMHost $BridgeheadServer -Name vSwitch1 |Remove-VirtualSwitch -Confirm:$false
Remove-VMHost -server $newvcenter -VMHost $migratinghost  -Confirm:$false # you have to wait till this host has disconnected from the new vcenter


Connect_management_servers

$gName = "vcd-vm1"
$gOrg = "Default-ORG"
$gOrgVdc = "Default VDC"
$gVApp = "vApp_system_3"
$gId = "urn:vcloud:vm:b123d55f-9422-48d0-b664-a28038b45c45"




get-vm -Server $vcenter -location "172.23.164.81"|where name -Clike "*(*"|where Powerstate -EQ "PoweredOn" |foreach {
$vmid =  $_.name.split("(")[-1]
$vmid = $vmid.Split(")")
$guestname = get-vm $_.name
$prefix = "urn:vcloud:vm:"
$vmid = $prefix+$vmid
$vmid = $vmid.Trim()
$vapp = get-civm -server  $oldvcdserver  -id "$vmid" | select name,  ORG, OrgVDC, vapp, ID
$guestname = get-vm $($_.name)
$orgvdc = get-orgvdc -server  $newvcdserver|where name -eq "$vapp.OrgVdc"
#New-CIVApp -server $newvcdserver -name $vapp.vapp -orgvdc $vapp.OrgVdc
#Import-CIVapp -server $newvcdserver -VM $guestname -OrgVdc $vapp.OrgVdc -NoCopy # -whatif
Import-CIVapp -server $newvcdserver -VM $guestname -vapp ImportedTestVM -NoCopy  -OrgVdc $vapp.OrgVdc # -whatif $vapp.vapp
}

$guestname = get-vm -server $newvcenter -location 172.23.164.81|where name -clike "*(a1*"
stop-vmguest -server $newvcenter -VM $guestname -Confirm:$false
Import-CIVapp -server $newvcdserver -VM $guestname -OrgVdc "Default VDC" -NoCopy
start-vm -server $newvcenter -VM $guestname -Confirm:$false




stop-vmguest -server $newvcenter -VM $guestname -Confirm:$false
Import-CIVapp -server $newvcdserver -VM $guestname -OrgVdc "Default VDC" -NoCopy
Import-CIVapp -server $newvcdserver -VM $guestname -vapp  "ImportedTestVM" -NoCopy:$true

$guestname = get-vm -server $newVcenter "ImportMe"
Import-CIVapp -server $newvcdserver -VM $guestname -vapp "Importtohere" -NoCopy
get-civapp "Importtohere" | Import-CIVapp -VM $guestname -NoCopy
Import-civm

Disconnect-CIServer $oldvcdserver

start-vm -server $newvcenter -VM $guestname -Confirm:$false

$newvcenter | Select Name,Version
$global:DefaultVIServers
Disconnect-VIServer *
               $credentials = Get-VICredentialStoreItem -User 'administrator@vsphere.local' -Host $newvcenter -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
               if (!$credentials){
                                        $credentials = Read-host -Prompt "Enter administrator@vsphere.local Password for $newvcenter" -AsSecureString
                                        $credentials = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credentials))
                                        New-VICredentialStoreItem -Host $vcenter -User 'administrator@vsphere.local' -Password $credentials -file C:\scripts\"$env:UserName"-vcenter_passwordfile.txt
                                        $credentials = Get-VICredentialStoreItem -User 'administrator@vsphere.local' -Host $newvcenter -File C:\scripts\"$env:UserName"-vcenter_passwordfile.txt|select -ExpandProperty password
                                                                                }
               Connect-VIServer $newvcenter -user administrator@vsphere.local -Password "$credentials"
               Remove-Variable credentials
$global:DefaultVIServers


get-vm $guestname | Import-CIVapp -server $newvcdserver -orgvdc $vapp.OrgVdc -NoCopy -whatif



 $myVm = "ImportedTestVM1"
$myvm = get-vm -server $newvcenter $myvm
 $myOrgVdc = "Default VDC"
Import-CIVapp -server $newvcdserver -VM $myVm -OrgVdc $myOrgVdc -NoCopy













Get-ciVApp -server  $oldvcdserver |where name -eq "vApp_system_3" |select *
Get-civm -server  $oldvcdserver |where name -eq "vcd-vm1" |select *
get-civm -server $oldvcdserver -id "urn:vcloud:vm:b123d55f-9422-48d0-b664-a28038b45c45"
get-civm -server $oldvcdserver -id "$vmid"

$vmlist =

get-vm -server $oldvcenter |where name -Clike "*(*" |foreach {
$vcdvm = get-civm -server  $oldvcdserver -name $($_.name) |select ORG, OrgVDC, vapp, ID
write-host Import-CIVapp -VM $vcdvm.name -OrgVdc $vcdvm.org -NoCopy
}


$id = "urn:vcloud:vm:b123d55f-9422-48d0-b664-a28038b45c45"
get-civm -server  $oldvcdserver -id $vmid |select *


get-civm -server  $oldvcdserver |select *  ORG, OrgVDC, vapp, ID # .split(":")[-1]
$vmlist.ID.split(":")[-1]


get-civm -name vcd-vm1 |select *

Get-CIVApp

write-host get-civm -server  $oldvcdserver |select ORG, OrgVDC, vapp, ID|where $($_.ID.split(":")[-1]) -EQ "$vm"
