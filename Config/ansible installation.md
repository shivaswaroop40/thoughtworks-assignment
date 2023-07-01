# Readme File for Ansible Installation on Host and Target Servers
## Host Server commands
Ubuntu ansible installation https://phoenixnap.com/kb/install-ansible-ubuntu-20-04
```
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
ansible --version
useradd ansible #adding ansible user
passwd ansible #configuring password for ansible user
```

- Below command addes ansible to sudoers file. But strongly recommended to use "visudo" command if you are aware vi or nano editor. 

```
echo "ansible ALL=(ALL) ALL" >> /etc/sudoers
```
- sed command replaces "PasswordAuthentication no to yes" without editing file

```
sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
ssh-keygen #generate an ssh key for public key authentication on the target server
ssh-copy-id username@<target-server>
echo "<target server IP>" > /etc/ansible/hosts
ansible all -m ping
```

## Target Server commands
```
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
ansible --version
useradd ansible
passwd ansible
```
```
echo "ansible ALL=(ALL) ALL" >> /etc/sudoers
```
- sed command replaces "PasswordAuthentication no to yes" without editing file

```
sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo service sshd reload
su - ansible
pip3 install ansible --user
ansible --version
```
-------------

Documented Errors while using CentOS for Ansible host:
``` 
CentOS-8 - AppStream 70 B/s | 38 B 00:00
Error: Failed to download metadata for repo 'AppStream': Cannot prepare internal mirrorlist: No URLs in mirrorlist 
```
Resolution from https://techglimpse.com/failed-metadata-repo-appstream-centos-8/
```
Step 1: Go to the /etc/yum.repos.d/ directory.

[root@autocontroller ~]# cd /etc/yum.repos.d/
Step 2: Run the below commands

[root@autocontroller ~]# sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*

[root@autocontroller ~]# sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

Step 3: Now run the yum update

[root@autocontroller ~]# yum update -y
 ```

But the above resolution did not work, CentOS 8 has reaached it end of life. Hence resorted to using Ubuntu 20.04 instead.

Below error when copying ssh-key onto target server
```
Permission denied (publickey)
```
Hence, added public key of host vm into target vm manually


