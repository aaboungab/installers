#!/bin/sh
# find link from downloads page
download_link=$(curl -s https://www.terraform.io/downloads.html | \
    grep -Eo 'https://releases.hashicorp.com/terraform/[0-9]+.[0-9]+.[0-9]+/terraform_[0-9]+.[0-9]+.[0-9]+_linux_amd64.zip')
# find version
version=$(echo ${download_link} | grep -Eo '\/[0-9]+.[0-9]+.[0-9]+\/' | sed 's/\///g')
install_folder="/opt/terraform/${version}"
echo "installing latest terraform version: ${version}"
sudo curl -s "${download_link}" -o "/tmp/terraform.zip"
sudo mkdir -p ${install_folder}
sudo unzip -qq -o /tmp/terraform.zip -d ${install_folder}
sudo chmod +x ${install_folder}/terraform
sudo ln -sfn ${install_folder} /opt/terraform/latest
sudo ln -sfn /opt/terraform/latest/terraform /usr/bin/terraform
echo "done"
