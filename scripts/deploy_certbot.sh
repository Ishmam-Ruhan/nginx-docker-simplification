#!/bin/bash

domains="$1"

IFS=" " read -ra domain_array <<< "$domains"

# Iterate over the array elements
for domain in "${domain_array[@]}"; do
    certbot_certificates=$(certbot certificates)

    if [[ $certbot_certificates =~ Certificate\ Name:\ $domain ]]; then
        command certbot delete --cert-name "$domain"
    fi
done

for domain_ in "${domain_array[@]}"; do
    domain_flags+="-d $domain_ "
done

command certbot --nginx $domain_flags