#!/bin/bash

# List of Docker containers to start and their corresponding delays in seconds
containers=(
  "container1:40"
  "container2:5"
  "container3:0"
)

# Function to start Docker containers with their respective delays
start_containers_with_delay() {
  for entry in "${containers[@]}"; 
  do
    IFS=':' read -r container delay <<< "$entry"
    echo "Starting $container..."
    unraid_notify "$Starting $container..." "normal"
	
    # Start the container and capture the output
    output=$(docker start "$container")

    # Check if the output contains the container name
    if [[ "$output" == "$container" ]]; then
      echo "$container started successfully."
	  unraid_notify "$container started successfully." "normal"
    else
      echo "Failed to start $container."
	  unraid_notify "Failed to start $container." "warning"
      # Optionally, you can exit the script if any container fails to start
      # exit 1
    fi

    echo "Waiting for $delay seconds before starting the next container..."
	unraid_notify "Waiting for $delay seconds before starting the next container..." "normal"
    sleep "$delay"
  done
}

unraid_notify() {
    local message="$1"
    local severity="$2"
	
    # Call the Unraid notification script
    /usr/local/emhttp/webGui/scripts/notify -s "Start Dockers" -d "$message" -i "$severity"
}

# Start the containers with their respective delays
start_containers_with_delay

echo "Script Finished ..."