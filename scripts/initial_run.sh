#!/bin/bash

command sleep 2
command chmod +x /opt/scripts/grant_permissions.sh
command /opt/scripts/grant_permissions.sh

command sleep 2
command /opt/scripts/required_apt_installations.sh

command sleep 2
command /opt/scripts/import_config_files.sh

command sleep 2
command /opt/scripts/certbot_renewal_cron.sh

command nginx -g 'daemon off;'
#-----------------------