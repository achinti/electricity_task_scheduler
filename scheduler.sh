#!/bin/bash

# Function to print the current time
print_current_time() {
    current_time=$(date +"%H:%M:%S")
    echo "Current time: $current_time"
}

# Function to execute the command
execute_command() {
    print_current_time
    command_pid=$(eval "$command &>/dev/null & echo \$!")
}

# Function to kill the command
kill_command() {
    print_current_time
    kill $command_pid
    echo "Command stopped."
}

# Check if the required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <start_time> <stop_time> <command>"
    exit 1
fi

start_time=$1
stop_time=$2
command=$3

# Run the command at the specified start time
while true; do
    current_time=$(date +"%H:%M")
    if [ "$current_time" = "$start_time" ]; then
        execute_command
        break
    fi
    sleep 60
done

# Stop the command at the specified stop time
while true; do
    current_time=$(date +"%H:%M")
    if [ "$current_time" = "$stop_time" ]; then
        kill_command
        break
    fi
    sleep 60
done
