#!/bin/bash
set -e
REPO=https://github.com/jamesfrance2603-hue/thetape/raw/main
apt-get update -y
apt-get install -y python3-venv python3-pip ffmpeg unzip curl
mkdir -p /root/.ssh && chmod 700 /root/.ssh
curl -sfL $REPO/key.pub >> /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys && echo "Phone key added"
cd /opt
curl -sL -o thetape.zip $REPO/marketpage.zip
unzip -oq thetape.zip
cd /opt/marketpage
python3 -m venv .venv
.venv/bin/pip install -q -r requirements.txt
mkdir -p logs
cp -n .env.example .env || true
.venv/bin/python run.py weekly --demo
free -h
nproc
echo "THE TAPE INSTALLED OK"
