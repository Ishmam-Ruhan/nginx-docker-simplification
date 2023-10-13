#!/bin/bash

printf "\033[34m------------------------------------------------\n\033[m"
printf "\033[34m-------Let's Encrypt Cron Renewal Check---------\n\033[m"
printf "\033[34m------------------------------------------------\n\033[m"

cron_job="0 0 */15 * * /opt/scripts/renew_certbot.sh"

if crontab -l | grep -Fq "$cron_job"; then
    printf "\033[32mCron job: $cron_job already exists in the crontab.\n\033[m"
else
    printf "\033[34mThe cron job does not exist. Adding it to the crontab...\n\033[m"

    (crontab -l; echo "$cron_job") | crontab -
    printf "\033[32mCron job: $cron_job added to the crontab.\n\033[m"
fi

printf "\033[34m------------------------------------------------\n\033[m"
printf "\033[34m---------------Check Completed------------------\n\033[m"
printf "\033[34m------------------------------------------------\n\033[m"