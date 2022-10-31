create a configuration file in your .ssh directory (.ssh/config) and set all the configurations there;

    ### The Proxy server
        Host name.of.your.bastion
        HostName proxyserver.ip
    ### if we don't use SSH key we introduction ssh User
        User your.username
        IdentityFile SSHkeydirectory
        Port portnumber

     ### The main server
        Host main-server-name
        HostName MainserverIP
        IdentityFile SSHkeydirectory
        ProxyJump proxy-host-name 
