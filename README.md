# xenorchestra_installer

OS Test: Ubuntu 16.04

The single line installation required the following steps from a root shell. 

Confirm your VM's IP Address before starting the script so you know where to login to. 

The default username and password are applied, admin@admin.net and admin for the password

    sudo bash
    <password>
    sudo curl https://raw.githubusercontent.com/scbrianti/xenorchestra_installer/master/xo_install.sh | bash
    <password>
    
    
If you don't want NFS capabilities run "sudo apt-get remove nfs-common".
