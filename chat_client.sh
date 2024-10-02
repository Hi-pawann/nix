#!/bin/bash
SERVER="localhost"
PORT=12345

echo "Connecting to chat server at $SERVER on port $PORT."

{
    nc $SERVER $PORT
} &

while true; do
    read MESSAGE
    echo "$MESSAGE" | nc $SERVER $PORT
done
