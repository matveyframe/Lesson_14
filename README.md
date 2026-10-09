1) Написать скрипт для поиска свободного порта из диапазона M-N, где M и N - передаются скрипту как аргументы
 ```
#!/bin/bash

read -p "Enter the starting port:" START_PORT
read -p "Enter the destination port:" END_PORT
COUNT="${START_PORT}"
HOST="localhost"

while [ "${COUNT}" -le "${END_PORT}" ]; do
   nc -zv $HOST $COUNT
   COUNT=$((COUNT + 1))
done
```
![](https://github.com/matveyframe/Lesson_14/blob/main/find_port%20result.PNG "Logo Title Text 1")

2) Написать скрипт, для деплоя лендинга https://gitlab.com/dos-26/cmdb/frontend и скрипт для его проверки
   
```
#!bin/bash

URL="https://gitlab.com/dos-26/cmdb/frontend"
OK_STATUS=$(curl -o /dev/null -s -w "%{http_code}" "$URL")

if [ "$OK_STATUS" -eq 200 ]; then
   echo "status site is OK"
else
   echo "status site is not OK"
fi 

```
![](https://github.com/matveyframe/Lesson_14/blob/main/landing-status_result.PNG "Logo Title Text 1")

3)Развернуть Python-веб-сервер как systemd демон
<p>-Сервер запущен как systemd демон с правами пользователя webadmin </p>
<p>-Пользователь webadmin не имеет shell-доступпа и является членом группы webgroup </p>
<p>-Код сервера расположен в директории /opt/srv/webapp; в той же диреткории лежит content/index.html с содержимым </p>

Unit файл:
```
[Unit]
Description= web-server
After=network-online.target

[Service]
User=webadmin
Group=webgroup
WorkingDirectory=/opt/srv/webapp/
ExecStart=/opt/srv/webapp/venv/bin/python /opt/srv/webapp/web-server.py
Restart=Always

[Install]
WantedBy=multi-user.target
```

Скрипт:
```
#!/bin/bash

SERVICE_NAME="web-server.service"
PORT=8080
URL="http://localhost:$PORT/health"
APP_USER="webadmin"
APP_GROUP="webgroup"
APP_DIR="/opt/srv/webapp"
REP_DIR="https://github.com/matveyframe/Lesson_14.git"
SERVICE_NAME="web-server.service"
INDEX_DIR="/opt/srv/webapp/content"


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
sudo mkdir "$INDEX_DIR" && sudo cp ./webapp/index.html "$INDEX_DIR"
sudo python3 -m venv ./webapp/venv
sudo cp "$APP_DIR/web-server.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl restart "$SERVICE_NAME"
sleep 5
}

user_add
deploy_app

```

![](https://github.com/matveyframe/Lesson_14/blob/main/web-server_result.PNG "Logo Title Text 1")
![](https://github.com/matveyframe/Lesson_14/blob/main/web-server_result.PNG "Logo Title Text 1")
