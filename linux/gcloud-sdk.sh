#!/bin/sh
# for centos/rhel, ubuntu & debian
if type apt > /dev/null; then 
# debian/ubuntu
#
# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    
# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    
# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install -y google-cloud-sdk
elif type yum > /dev/null; then
# centos/rhel
#
# Update YUM with Cloud SDK repo information:
sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
    # The indentation for the 2nd line of gpgkey is important.
    # Install the Cloud SDK
    sudo yum install -y google-cloud-sdk
fi
