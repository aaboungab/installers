#!/bin/sh
if type apt > /dev/null; then
    pkg_mgr=apt
    java="openjdk-8-jre"
elif type yum /dev/null; then
    pkg_mgr=yum
    java="java"
fi
echo "installing dependencies"
sudo ${pkg_mgr} install -y ${java} curl
echo "configuring jenkins user"
sudo useradd -m -s /bin/bash
echo "downloading latest jenkins WAR"
sudo su - jenkins -c "curl https://updates.jenkins-ci.org/latest/jenkins.war -O"
echo "setting up jenkins service"
sudo tee /etc/systemd/system/jenkins.service << EOF
[Unit]
Description=Jenkins Server

[Service]
User=jenkins
WorkingDirectory=/home/jenkins
ExecStart=/usr/bin/java -jar /home/jenkins/jenkins.war

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable --now jenkins
