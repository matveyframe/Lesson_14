#!/bin/bash

SERVICE_NAME="web-server.service"
PORT=8080
URL="http://localhost:$PORT/health"
APP_USER="webadmin"
APP_GROUP="webgroup"
APP_DIR="/opt/srv/webapp"
REP_DIR="https://github.com/matveyframe/Lesson_14.git"
SERVICE_NAME="web-server.service"


user_add() {
   if id "$APP_USER" &>/dev/null; then
   echo "$APP_USER already exists"
   else sudo adduser --disabled-password --gecos "$APP_USER" --shell /bin/false --ingroup "$APP_GROUP" "$APP_USER"
fi
}

deploy_app() {
if [ -d "$APP_DIR/.git" ]; then
 cd "$APP_DIR" && git pull
else sudo git clone "$REP_DIR" "$APP_DIR"
fi
chown -R "$APP_USER":"$APP_GROUP" "$APP_DIR"
sudo mkdir ./content && cp index.html ./content
sudo python3 -m venv venv
sudo cp "$APP_DIR/web-server.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl restart "$SERVICE_NAME"
sleep 5
}

user_add
deploy_app

