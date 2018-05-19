#!/usr/bin/env bash

for i in $(seq 1 500);
do
    data=$(curl https://carmel.instructure.com/eportfolios/$i -I 2>/dev/null)
    status=$(echo $data | grep Status | cut -d$' ' -f2)
    if [[ "$status" == "200"  ]];
    then
        echo "ID $i Found!"
    fi
    # TODO: keep incremeting i until a 404?
done
