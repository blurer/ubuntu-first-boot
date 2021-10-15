#!/bin/bash

user=bl
echo 'bl-aws' > /etc/hostname

echo '--| Update |--'
apt update -y 
apt upgrade -y 
apt install sudo -y

echo '--| Create User |--'
useradd bl -d /home/bl 
usermod -aG sudo bl
mkdir /home/bl/
echo "bl  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

echo '--| Copy Defaults |--'
cp -ar /etc/skel/.profile /home/$user/
cp -ar /etc/skel/.bashrc /home/$user/
chown -R $user:$user /home/$user 
chmod 700 /home/$user

echo '--| Copy SSH Keys |--'
mkdir /home/bl/.ssh/
touch /home/bl/.ssh/authorized_keys
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEj8Kjzd0hKxTwTcenGaHfa8bWWtzOIGUE/k3xe+omr1 bryanlurer@Bryans-MacBook.local' >> /home/bl/.ssh/authorized_keys
chown -R bl:bl /home/bl/.ssh/
chmod 600 /home/bl/.ssh/*

echo '--| Set Shell |--'
usermod --shell /bin/bash $user

echo '--| Disable Root Login SSH |--'
usermod -s /sbin/nologin root

echo '--| Install Base Apps |--'
sudo apt install -y -qq \
	htop \
	vim \
	git \
	curl \
	ansible \
	zsh \
	nmap \
	tshark \
	python3-pip \
	python3-setuptools \
	build-essential \
	glances \
	python-apt \
	p7zip \
	rclone \
	ffmpeg \
	youtube-dl \
	apt-transport-https \
	fail2ban 
	
curl -fsSL https://get.docker.com -o get-docker.sh 
sh get-docker.sh

apt install -y docker-compose

useradd bl
usermod -aG docker bl
usermod -aG sudo bl
userdel ubuntu
rm -rf /home/ubuntu/


