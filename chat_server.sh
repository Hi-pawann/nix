#!/bin/bash
PORT=12345
PIPE=$(mktemp -u)
mkfifo $PIPE

{
    while true; do
        cat $PIPE | nc -l -p $PORT
    done
} &

echo "Chat server started on port $PORT."

while true; do
    read MESSAGE
    echo "$MESSAGE" > $PIPE
done
