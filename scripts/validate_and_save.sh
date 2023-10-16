#!/bin/bash

json_file="$1"

copy_configurations_directory="/opt/generated-configurations"


#Create directory if not exists
mkdir -p "$copy_configurations_directory"

nginx_conf_directory="/etc/nginx/conf.d"

config_filename=$(jq -r '.config_filename' "$json_file")

nginx_conf_file="$nginx_conf_directory/$config_filename.conf"
local_conf_file="$copy_configurations_directory/$config_filename.json"

# Function to check if the configuration matches the JSON data
check_configuration() {
  if [ -f "$nginx_conf_file" ]; then
    existing_config=$(cat "$local_conf_file")
    new_config=$(cat "$json_file")

    if [ "$existing_config" = "$new_config" ]; then
      printf "\033[32mThe $config_filename file is the okay as the current JSON data. No changes needed.\n\033[m"
    else
      printf "\033[34mThe $config_filename file is different from the current JSON data. Generating a new $config_filename file...\n\033[m"
      command rm -f $nginx_conf_file
      command rm -f $local_conf_file
      command /opt/scripts/generate_config.sh "$json_file" "$nginx_conf_file" "$local_conf_file"
    fi
  else
    printf "\033[34mThe $config_filename file does not exist. Generating a new configuration file...\n\033[m"
    command /opt/scripts/generate_config.sh "$json_file" "$nginx_conf_file" "$local_conf_file"
  fi
}

check_configuration
