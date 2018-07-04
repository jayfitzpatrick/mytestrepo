# Test PS script via Atom

$serverlist = "1","2"
foreach ($server in $serverlist) {
write-host $server
 ([adsisearcher]"(&(name=$Server)(objectClass=computer))").findall().path
 }
