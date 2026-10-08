#!/bin/bash

read -p "Enter the starting port:" START_PORT
read -p "Enter the destination port:" END_PORT
COUNT="${START_PORT}"
HOST="localhost"

while [ "${COUNT}" -le "${END_PORT}" ]; do
   nc -zv $HOST $COUNT
   COUNT=$((COUNT + 1))
done
 


