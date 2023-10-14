#!/bin/bash

# Specify the directory containing JSON files
json_directory="/opt/configs"

# Check if the directory exists
if [ ! -d "$json_directory" ]; then
  printf "\033[31mConfig directory at: $json_directory not found!\n\033[m"
  exit 1
fi

# Loop through JSON files in the directory
for json_file in "$json_directory"/*.json; do
  if [ -f "$json_file" ]; then
    printf "\033[32mWorking with JSON file: $json_file\n\033[m"
    command /opt/scripts/validate_and_save.sh "$json_file"
  fi
done
