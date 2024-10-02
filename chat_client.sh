#!/bin/bash
SERVER="localhost"
PORT=12345

read -p "Enter your username: " USERNAME

{
    while true; do
        nc $SERVER $PORT | sed "s/^/$USERNAME: /"
    done
} &

while true; do
    read MESSAGE
    echo "$USERNAME: $MESSAGE" | nc $SERVER $PORT
done
