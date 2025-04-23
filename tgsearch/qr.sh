#!/bin/bash

storage=$(cat /proc/mounts | grep /dev/mapper/vg_lvm-pvc | awk '{print $2}')
if [ -n "$storage" ] && [ -d "$storage" ]; then
    echo "使用挂载目录: $storage"
    ./tgsearch.x86_64 -q | while read -r line; do
        if echo "$line" | grep -q "V1 QRCode Login Url:"; then
            url=$(echo "$line" | sed 's/.*V1 QRCode Login Url: //')
            clear
            qrencode -t ansi "$url"
        fi

        if echo "$line" | grep -q "V1 login success, telegram V1 session_string:"; then
            v1_session=$(echo "$line" | sed 's/.*V1 session_string: //')
            echo "$v1_session" > v1.txt
            echo "V1 session_string saved to v1.txt"
        fi

        if echo "$line" | grep -q "V2 session_string:"; then
            v2_session=$(echo "$line" | sed 's/.*V2 session_string: //')
            echo "$v2_session" > v2.txt
            echo "V2 session_string saved to v2.txt"

            cp v1.txt "$storage/"
            cp v2.txt "$storage/"
            break
        fi
    done
else
    echo "未使用挂载目录"
    ./tgsearch.x86_64 -q | while read -r line; do
        if echo "$line" | grep -q "V1 QRCode Login Url:"; then
            url=$(echo "$line" | sed 's/.*V1 QRCode Login Url: //')
            clear
            qrencode -t ansi "$url"
        fi

        if echo "$line" | grep -q "V1 login success, telegram V1 session_string:"; then
            v1_session=$(echo "$line" | sed 's/.*V1 session_string: //')
            echo "$v1_session" > v1.txt
            echo "V1 session_string saved to v1.txt"
        fi

        if echo "$line" | grep -q "V2 session_string:"; then
            v2_session=$(echo "$line" | sed 's/.*V2 session_string: //')
            echo "$v2_session" > v2.txt
            echo "V2 session_string saved to v2.txt"
            break
        fi
    done
fi
