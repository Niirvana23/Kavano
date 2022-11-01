For this question, we must edit Haproxy config in /etc/haproxy/haproxy.cfg and replace the new config on that.

In HAproxy we can read and rewrite the header of a packet, Use the HTTP-request configuration directives to rewrite HTTP requests.
We can place it in a frontend, listen, or backend section. 
Use them to rewrite requests sent from clients before HAProxy forwards them to a backend server. The server will see something different than what the client sent.
Here we used ACL to redirect and proxy traffic on the specified backend, So that if a request is sent to a specific address, it will be directed to the desired server.

Explanation of the parts included in the config file

In the global section, we specified the user and the group related to Haproxy, Also the parts related to the log are specified in this section.

the default section for setting a default value and mode in haproxy, in this section we used HTTP mode for default and set timeout time for all parts.
### Listen
A listen is a combined frontend and backend, here we set ACL to restrict incoming data for server app 2 and app3. 
Here we specified that all traffic for a specified source address should be directed to servers 2 and 3 only.
Here, we used TCP to limit the traffic so that if a request is received apart from the HTTP protocol, it can be identified and the traffic blocked.

### Frontend:
another section is frontend A frontend defines how requests should be forwarded to backends. Frontends are defined in the frontend section of the HAProxy configuration.
Their definitions are composed of the following components:
* set of IP addresses and a port (e.g. 10.1.1.7:80, *:443, etc.)
* ACLs
* use_backend rules 


In this section, we can control incoming requests and view received packets, and filter these packets.
for the view header and body of all packets and filters we used "ACL". with ACL, we can specify desired addresses and direct the traffic received for these addresses to the desired server.
In this section, by reading the packet header and identifying the address, we find out which address is the address entered by the user and determine the responding server's address.

	acl pro_acl  hdr_end(host) -i -m str pro.example.com
	acl beta_acl  hdr_end(host) -i -m str beta.example.com
In the above commands, we used ACL to separate the "Pro" and "Beta" addresses from each other.

	acl subroute1 path_beg -i /v1/
	acl subroute2 path_beg -i /v2/
And here we use the fetch method to select the address and the part of the URL to identify the desired address.

### Backend:
A backend is a set of servers that receive forwarded requests. Backends are defined in the backend section of the HAProxy configuration.
In its most basic form, a backend can be defined by:
* which load balance algorithm to use
* a list of servers and ports

in this config we used the roundrobin algorithm for load balance traffic, also default algorithm in haproxy is roundrobin. 
we could use the "Leastconn" algorithm, in this algorithm we check the number of connections of each server, and the traffic is sent to the server with fewer connections.
check parameter, This instructs HAProxy to perform health checks on the node.
in this section we used the "inter" parameter, The inter parameter changes the interval between checks; it defaults to two seconds. The fall parameter sets how many failed checks are allowed;
it defaults to three. The rise parameter sets how many passing checks there must be before returning a previously failed server to the rotation; it defaults to two.

Slow start mode limits and meters the traffic forwarded to a server that is just back online.
By using the slow start option, we can direct the incoming traffic to the server in a reasonable period of time so that the server does not face a flood of traffic.
