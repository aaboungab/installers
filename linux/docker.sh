#!/bin/bash
echo "installing docker"
curl https://get.docker.com | sudo bash
sudo systemctl enable --now docker
sudo usermod -aG docker $(whoami)
echo "done"
echo "logout and back in to be able to run docker commands without sudo"
