#!/bin/bash

printf "\033[34m------------------------------------------------\n\033[m"
printf "\033[34m-----Granting Script Execution Permissions------\n\033[m"
printf "\033[34m------------------------------------------------\n\033[m"

command chmod +x /opt/scripts/import_config_files.sh
printf "\033[32mPermissions granted to:  /opt/scripts/import_config_files.sh\n\033[m"

command chmod +x /opt/scripts/validate_and_save.sh
printf "\033[32mPermissions granted to:  /opt/scripts/validate_and_save.sh\n\033[m"

command chmod +x /opt/scripts/generate_config.sh
printf "\033[32mPermissions granted to:  /opt/scripts/generate_config.sh\n\033[m"

command chmod +x /opt/scripts/deploy_certbot.sh
printf "\033[32mPermissions granted to:  /opt/scripts/deploy_certbot.sh\n\033[m"

command chmod +x /opt/scripts/renew_certbot.sh
printf "\033[32mPermissions granted to:  /opt/scripts/renew_certbot.sh\n\033[m"

command chmod +x /opt/scripts/certbot_renewal_cron.sh
printf "\033[32mPermissions granted to:  /opt/scripts/certbot_renewal_cron.sh\n\033[m"

command chmod +x /opt/scripts/required_apt_installations.sh
printf "\033[32mPermissions granted to:  /opt/scripts/required_apt_installations.sh\n\033[m"

printf "\033[34m--------------Permissions Granted---------------\n\n\033[m"