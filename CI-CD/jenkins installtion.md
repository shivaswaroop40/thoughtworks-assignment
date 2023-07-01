# Readme File to install Jenkins on the Host Server
```
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update

sudo apt install openjdk-11-jre

java -version

sudo apt-get update

sudo apt-get install jenkins

sudo systemctl enable jenkins

sudo systemctl start jenkins

sudo systemctl status jenkins
```

## Jenkins Setup

- Login to Jenkins with default credentials

- Install all recommended plugins

- Install GitHub plugin for SCM polling

- Configure GitHub plugin in global settings with project URL and PAT

- Install Ansible plugin

- Configure Ansible plugin with the installation path

- Create a global credential with ssh key of target server for ansible host key authentication

- Create new item(pipeline) with git checkout and ansible playbook steps, and enable GitHub SCM polling.

- Create webhook in github with the jenkins server ```jenkins-ip/github-webhook/``` for push events

- Make changes in GitHub to create a build in Jenkins

- Once build is complete, visit http://target-server-ip:8080 to view Mediawiki server.