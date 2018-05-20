#!/usr/bin/env bash

for i in $(seq 1 1000);
do
    echo -ne "Trying $i...\t\r"

    data=$(curl https://carmel.instructure.com/eportfolios/$i -I 2>/dev/null)
    status=$(echo $data | grep Status | cut -d$' ' -f2)

    if [[ "$status" == "200"  ]];
    then
        data=$(curl https://carmel.instructure.com/eportfolios/$i 2>/dev/null | tr '\n' ' ')
        title=$(echo $data | sed -re 's;(.*?)<div class="eportfolio-name"> <h3>([^<]*?)</h3>(.*?);\2;g')
        name=$(echo $data | sed -re 's;(.*?)<span id="section-tabs-header-subtitle" class="ellipsis">([^<]*?)</span>(.*?);\2;g')
        echo -e "ID $i Found, Title: $title, Name: $name\t"
    fi
done
