# Assignment Readme File
╷
│ Error: Incompatible provider version
│ 
│ Provider registry.terraform.io/hashicorp/template v2.2.0 does not have a package available for your current platform, darwin_arm64.
│ 
│ Provider releases are separate from Terraform CLI releases, so not all providers are available for all platforms. Other versions of this provider may have different platforms supported.


Here are the simple steps to resolve this issue:

1. Install “m1-terraform-provider-helper” with the help of the below command:

brew install kreuzwerker/taps/m1-terraform-provider-helper
2. Activate the plugin or helper utility.

m1-terraform-provider-helper activate
3. Install and compile the “hashicorp/template v2.2.0”.

m1-terraform-provider-helper install hashicorp/template -v v2.2.0

Created Key vault mediawiki-kv in budget-rg 

Added public key generated locally to a secret on the keyvault

Accessing vm through ssh keys

az keyvault secret set --name id_rsa --vault-name mediawiki-kv --resource-group budget-rg --file ~/.ssh/id_rsa

--------------------------------------------------------

added ssh access to target vm with host vm IP

added public key of host vm into target vm manually

added 8080 port for jenkins on host vm

# Jenkins Installation

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

sudo apt update
sudo apt install openjdk-11-jre
java -version

sudo systemctl enable jenkins

sudo systemctl start jenkins

sudo systemctl status jenkins

