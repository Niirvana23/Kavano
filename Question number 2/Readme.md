###  I did not understand what you meant by this question, If the purpose of security is to use the SSH protocol, we can use the following methods:
#### We have several solutions to secure our SSH connection:
1. As an immediately work, we need to change Default SSH port from 22 to custom port.
For change this port we must edit ssh config file in /etc/ssh/ssh_config and change “Port 22” section to custom number of port that we want to set.
2. Use SSH key instead of password
	Actually, using a password is not secure way to connect server. We can use Certificate to create security and limited access of each user to the server. 
	We use the following method to create a certificate:
	Generate certificate with ssh-keygen command on host (in this method we can use another location for save Public and Private Key) 
		The most important thing is that we must use a password for our certificate
      	Copy public key to another server with ssh-copy-id command 
        	Use it like this command:
		
		ssh-copy-id [-i identity file] [-p port] [user]@hostname 
3. Two-step authentication method
	In this method, we can use the combination of two methods of password and verification by sending an SMS to the mobile phone or sending an email.
	In this method we can used PAM (Google Authenticator)
	To make SSH use the Google Authenticator PAM module, add the following line to the /etc/pam.d/sshd file:
	auth required pam_google_authenticator.so
	Now you need to restart the sshd daemon
	After that we must to modify ChallengeResponseAuthentication in /etc/ssh/sshd_config file, 	change status from No to Yes.	

### But if the purpose is to hide the IP of the servers and not to access them from outside the network and achieve the highest level of security,the following methods are recommended.
#### SSH into the private server through Bastion Host:
	
In this method, the main server does not have access to the Internet and is used in a private network, in this case our server is protected from attacks through the Internet and outside the network.

For this, we use a proxy server to pass the internet traffic through this service and connect to main server via this.
- Both of the declared methods are used for secure SSH connection between the proxy server and the primary server. 

For connect proxy server and after that connect to Main server we use below command:

	 ssh –J “proxy server” “main server”

For one time solution, the above configuration can be fine but if in case we need to login into the remote server multiple times a day then the above method won’t be feasible. We can hard code the above procedure into the ~/.ssh/config file which eases you to log into the remote server.

Once this configuration is set into the ~/.ssh/config then you can directly ssh into the main server.
