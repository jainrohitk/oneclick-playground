#!/bin/bash

#Install Docker
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

systemctl enable docker
systemctl start docker
service docker start

#Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin
kubectl version

#Install kind
curl -Lo kind "https://kind.sigs.k8s.io/dl/v0.15.0/kind-linux-amd64"
chmod +x kind
mv kind /usr/local/bin/kind
kind --version

#Install istioctl
cd /tmp
curl -L "https://istio.io/downloadIstio" | sh -
cd istio-*/bin;chmod +x istioctl
mv istioctl /usr/local/bin
istioctl version

# Install Halyard
curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh
sudo bash InstallHalyard.sh
hal -v

#Install terraform
sudo apt-get install wget unzip
curl -LO "https://releases.hashicorp.com/terraform/1.2.9/terraform_1.2.9_linux_amd64.zip"
unzip terraform_1.2.9_linux_amd64.zip
chmod +x terraform
mv terraform /usr/local/bin/

#Install terragrunt
curl -Lo terragrunt "https://github.com/gruntwork-io/terragrunt/releases/download/v0.38.9/terragrunt_linux_amd64"
chmod +x terragrunt
mv terragrunt /usr/local/bin/
terragrunt --version