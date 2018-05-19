#!/usr/bin/env bash

for i in $(seq 1 1000);
do
    echo -ne "Trying $i...\t\r"

    data=$(curl https://carmel.instructure.com/eportfolios/$i -I 2>/dev/null)
    status=$(echo $data | grep Status | cut -d$' ' -f2)

    if [[ "$status" == "200"  ]];
    then
        data=$(curl https://carmel.instructure.com/eportfolios/$i 2>/dev/null)
        name=$(echo $data | sed -re 's;(.*?)<span id="section-tabs-header-subtitle" class="ellipsis">([^<]*?)</span>(.*?);\2;g')
        echo -e "ID $i Found, Name: $name\t"
    fi
done
