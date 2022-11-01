Imagine this situation:

You have three servers with Nginx running and an app like python is being served.
- Server 1 has IP 192.168.10.10 and App 1
- Server 2 has IP 192.168.10.11 and App 2.
- Server 3 has IP 192.168.10.12 and App 3.

Now you get another server and you want to manage and balance your servers using
HAProxy.

App 1 is supposed to be accessed when a user types “pro.example.com”.

App 2 is supposed to be accessed when a user requests “beta.example.com” and
subroute “/v1”.

App 3 is supposed to be accessed when a user requests “beta.example.com” and
subroute “/v2”.

- Apps 2 and 3 are not supposed to be viewed by the public and only by “192.168.100.0/24” which is our corporation’s LAN IP range.
