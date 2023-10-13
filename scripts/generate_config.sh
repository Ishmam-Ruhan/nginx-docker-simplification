#!/bin/bash

json_file="$1"
output_file="$2"

# Use jq to extract JSON data into variables
config_filename=$(jq -r '.config_filename' "$json_file")
isRequiredEncryption=$(jq -r '.enable_encryption' "$json_file")

root_config=$(jq -r '.root_config' "$json_file")
root_config_array=$(echo "$root_config" | jq -r 'to_entries | .[] | "\(.key)=\(.value)"')

location_config=$(jq -r '.location_config' "$json_file")

location_config_obj=$(echo "$location_config" | jq -r 'to_entries | .[] | "\(.key)=\(.value)"')

sanitize_domain() {
    local input="$1"
    # Trim leading and trailing spaces
    input="${input#"${input%%[![:space:]]*}"}"
    input="${input%"${input##*[![:space:]]}"}"

    # Replace multiple spaces with a single space
    input=$(echo "$input" | sed 's/ \{1,\}/ /g')
    echo "$input"
}


while IFS="=" read -r key value; do
  if [ "$key" == "server_name" ]; then
      value=$(sanitize_domain "$value")
      domains=$value
      nginx_config="$nginx_config  $key $domains;\n"
  else
      nginx_config="$nginx_config  $key $value;\n"
  fi
done <<< "$root_config_array"

# Initialize an associative array
declare -A location_config_array

# Split the text into lines and process each line
while IFS= read -r line; do
  # Extract key and value using awk
  key=$(awk -F'=' '{print $1}' <<< "$line")
  value=$(awk -F'=' '{print $2}' <<< "$line")
  location_config_array["$key"]=$value
done <<< "$location_config_obj"

array_keys=($(echo "${!location_config_array[@]}" | tr ' ' '\n' | tac))

# Print the key-value pairs in the associative array
for key in "${array_keys[@]}"; do
  location_pattern=$(echo "${location_config_array[$key]}" | jq -r '.location_pattern')
  params=$(echo "${location_config_array[$key]}" | jq -r '.params')
  param_array=$(echo "$params" | jq -r 'to_entries | .[] | "\(.key)=\(.value)"')

  # Create the location block using variables
  location_block="$location_block\n  location $location_pattern {\n"
  while IFS="=" read -r key value; do
    location_block="$location_block      $key   $value;\n"
  done <<< "$param_array"
  location_block+="  }\n"
done

nginx_config="server{\n$nginx_config $location_block\n}\n"

echo -e "$nginx_config" > "$output_file"

printf "\033[32mNginx configuration for $config_filename has been generated and saved to $output_file.\n\033[m"

if [ "$isRequiredEncryption" == "true" ]; then
    printf "\033[32mPerforming certbot encryption for domains: $domains\n\033[m"
    command /opt/scripts/deploy_certbot.sh "$domains"
fi