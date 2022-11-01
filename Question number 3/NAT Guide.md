To communicate and connect to the Internet through the desired server, we should consider server 3 as a router server.

For this, we must first set up the routing (forwarding) on the server and then direct the outgoing traffic through the IPTables firewall to the network interface of our server.

Then we need to activate the NAT operation so that the incoming traffic to our server 3, which is received from server 2 and server 1, will be sent to the Internet with the "server3" IP addresses.

Use Server 3 as a router:
The first step to creating a routing server is to activate the ip_forward in Linux distribution:

	``` echo 1 > /proc/sys/net/ipv4/ip_forward ```

After this step, we have to prepare IPtable for NAT operation:

	``` iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE```

The next step is to accept incoming traffic from  eth0:

	```iptables -A INPUT -i eth0 -j ACCEPT ```


Allow established connections from the public interface and use the bellow command:

	``` iptables -A INPUT -i eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT ```

In the last step, we have to confirm all outgoing traffic from server 3 so that there is no problem in providing answers to servers 1 and 2:

	``` iptables -A OUTPUT -j ACCEPT ```

#### Change Gateway config in server 2 and server 3:
After these steps on server 3, we must set the server 1 and server 2 gateway to the server 3  IP:

    Run the chroute.sh script on each server and restart the server.
