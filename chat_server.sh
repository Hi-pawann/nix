#!/bin/bash
PORT=12345
CLIENTS=()

mkfifo chat_pipe

{
    while true; do
        if read MESSAGE < chat_pipe; then
            for CLIENT in "${CLIENTS[@]}"; do
                echo "$MESSAGE" > "$CLIENT"
            done
        fi
    done
} &

while true; do
    nc -l -p $PORT | {
        read USERNAME
        CLIENT_FD=$(tty)
        CLIENTS+=("$CLIENT_FD")
        echo "User $USERNAME has joined the chat."

        while read LINE; do
            echo "$USERNAME: $LINE" > chat_pipe
        done

        CLIENTS=("${CLIENTS[@]/$CLIENT_FD}")
        echo "User $USERNAME has left the chat."
    }
done
