$Dominio = ("docnix.com.br")
$NovoIP = ("192.168.2.7")
$AntigoIP = ("192.168.25.7")
foreach ($_HOST in Get-DnsServerResourceRecord -ZoneName $Dominio -RRType A | where-object {$_.RecordData.ipv4address -eq $AntigoIP}|Select-Object -ExpandProperty HostName)
{
  Write-Output $_HOST
  $OldObj = Get-DnsServerResourceRecord -Name $_HOST -ZoneName $Dominio -RRType "A"
  $NewObj = $OldObj.Clone()
  $NewObj.RecordData.ipv4address=[System.Net.IPAddress]::parse($NovoIP)
  Set-DnsServerResourceRecord -NewInputObject $NewObj -OldInputObject $OldObj -ZoneName $Dominio -PassThru
  
}
