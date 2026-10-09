#!bin/bash

URL="https://gitlab.com/dos-26/cmdb/frontend"
OK_STATUS=$(curl -o /dev/null -s -w "%{http_code}" "$URL")

if [ "$OK_STATUS" -eq 200 ]; then
   echo "status site is OK"
else
   echo "status site is not OK"
fi 


