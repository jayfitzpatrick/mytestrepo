


$serverlist = "1","2"
foreach ($server in $serverlist)
 ([adsisearcher]"(&(name=$Server)(objectClass=computer))").findall().path
