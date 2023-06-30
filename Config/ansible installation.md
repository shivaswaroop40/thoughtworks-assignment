#! /bin/bash

### Master Node commands
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install ansible -y 
ansible --version
useradd ansible
passwd ansible
# below command addes ansible to sudoers file. But strongly recommended to use "visudo" command if you are aware vi or nano editor. 
echo "ansible ALL=(ALL) ALL" >> /etc/sudoers
# sed command replaces "PasswordAuthentication no to yes" without editing file 
sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
ssh-keygen
ssh-copy-id <target-server>
echo "<target server IP>" > /etc/ansible/hosts
ansible all -m ping

### Slave Node commands
yum install python3 -y
alternatives --set python /usr/bin/python3
python --version
yum -y install python3-pip
useradd ansible
passwd ansible
echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# sed command replaces "PasswordAuthentication no to yes" without editing file 
sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo service sshd reload
su - ansible
pip3 install ansible --user
ansible --version
ssh-keygen
ssh-copy-id ansible@<target-server>

Create a directory /etc/ansible and create an inventory file called "hosts" add control node IP address in it.s

Step 1: Go to the /etc/yum.repos.d/ directory.

[root@autocontroller ~]# cd /etc/yum.repos.d/
Step 2: Run the below commands

[root@autocontroller ~]# sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
[root@autocontroller ~]# sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
Step 3: Now run the yum update

[root@autocontroller ~]# yum update -y

Ubuntu ansible installation https://phoenixnap.com/kb/install-ansible-ubuntu-20-04

added public key of host vm into target vm manually

sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible

on master node
# adduser [username]

# usermod -aG sudo [username]

$ ssh-keygen

$ ssh-copy-id username@remote_host

$ sudo nano /etc/ansible/hosts

$ ansible-inventory --list -y


