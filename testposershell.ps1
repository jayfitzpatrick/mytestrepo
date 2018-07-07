# Test PS script via Atom
#v.4

$serverlist = "1","2"
foreach ($server in $serverlist) {
write-host $server
 ([adsisearcher]"(&(name=$Server)(objectClass=computer))").findall().path
 }
