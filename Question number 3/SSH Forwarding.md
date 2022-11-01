The solution to this question is to use IPtable port forwarding:

we used the bellow command for connecting server 1 and server 2 via port forwarding:
First step we must run bellow command on each 2 server. Basically, iptables nat masquerade functions as a router:

	``` iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE ```
	
	``` iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE ```

	
To allow Forward traffic between your public and private interfaces, run the following commands:
		
	``` iptables -A FORWARD -i eth1 -o eth0 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT ```

If we SSH to server 3 on port 3358, port forwarding is done, and Redirect my request to server 1:
	
	``` iptables -t nat -A PREROUTING -i eth1 -d 10.10.10.20 -p tcp --dport 3358 -j DNAT --to-destination 192.168.100.10:22 ``` 

If we SSH to server 3 on port 3360, port forwarding is done, and Redirect my request to server 2:
	
	``` iptables -t nat -A PREROUTING -i eth1 -d 10.10.10.20 -p tcp --dport 3360 -j DNAT --to-destination 192.168.100.11:22 ``` 

after that to alowed forwarding ssh request uses the bellow command on two servers:
on server1:

	``` iptables -A FORWARD -p tcp -d 192.168.100.10 --dport 22 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT ```

On server2:

	``` iptables -A FORWARD -p tcp -d 192.168.100.11 --dport 22 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT ```
