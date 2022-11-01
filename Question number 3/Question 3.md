You have 3 servers:

● Server 1 with private IP 192.168.100.10(interface eth0).

● Server 2 with private IP 192.168.100.11(interface eth0).

● Server 3 with private IP 192.168.100.12(interface eth0) and public IP
10.10.10.20(interface eth1).

Servers 1 and 2 must have internet access with public IP 10.10.10.20.

If someone wants to connect to these servers via ssh, they have to go through server 3
and you should forward them to certain ports(e.g. 22) of your servers
