#!/bin/bash

printf "\033[34m------------------------------------------------\n\033[m"
printf "\033[34m-------Installing Required Apt Packages---------\n\033[m"
printf "\033[34m------------------------------------------------\n\033[m"


# Check if Certbot is installed
if ! command -v certbot &> /dev/null; then
    printf "\033[32mCertbot is not installed. Attempting to install...\n\033[m"
    command apt update
    command apt install certbot -y

    # Check if installation was successful
    if ! command -v certbot &> /dev/null; then
        printf "\033[31mCertbot installation failed. Please install Certbot manually.\n\033[m"
        exit 1
    else
        printf "\033[34mCertbot has been successfully installed.\n\033[m"
    fi
else
    printf "\033[32mCertbot is already installed.\n\033[m".
fi

# Check if JQ is installed
if ! command -v jq &> /dev/null; then
    printf "\033[32mJQ is not installed. Attempting to install...\n\033[m"

    command apt install jq -y

    # Check if jq installation was successful
    if ! command -v jq &> /dev/null; then
        printf "\033[31mJQ installation failed. Please install Certbot manually.\n\033[m"
        exit 1
    else
        printf "\033[34mJQ has been successfully installed.\n\033[m"
    fi
else
    printf "\033[32mJQ is already installed.\n\033[m".
fi

# Check if CRON is installed
if ! command -v cron &> /dev/null; then
    printf "\033[32mCRON is not installed. Attempting to install...\n\033[m"

    command apt install cron -y

    # Check if cron installation was successful
    if ! command -v cron &> /dev/null; then
        printf "\033[31mCRON installation failed. Please install Certbot manually.\n\033[m"
        exit 1
    else
        printf "\033[34mCRON has been successfully installed.\n\033[m"
    fi
else
    printf "\033[32mCRON is already installed.\n\033[m".
fi

printf "\033[34m------------------------------------------------\n\033[m"
printf "\033[34m--------- ---Completed Installation-------------\n\033[m"
printf "\033[34m------------------------------------------------\n\033[m"