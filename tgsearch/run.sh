#!/bin/bash

storage=$(cat /proc/mounts | grep /dev/mapper/vg_lvm-pvc | awk '{print $2}')

if [ -n "$storage" ] && [ -d "$storage" ]; then
    # 检查并保存API_SESSION_V1
    if [ -n "$API_SESSION_V1" ]; then
        echo "$API_SESSION_V1" > "$storage/v1.txt"
        echo "Saved API_SESSION_V1 to $storage/v1.txt"
    fi
    # 检查并保存API_SESSION
    if [ -n "$API_SESSION" ]; then
        echo "$API_SESSION" > "$storage/v2.txt"
        echo "Saved API_SESSION to $storage/v2.txt"
    fi
else
    # 检查并保存API_SESSION_V1
    if [ -n "$API_SESSION_V1" ]; then
        echo "$API_SESSION_V1" > "v1.txt"
        echo "Saved API_SESSION_V1 to v1.txt"
    fi
    # 检查并保存API_SESSION
    if [ -n "$API_SESSION" ]; then
        echo "$API_SESSION" > "v2.txt"
        echo "Saved API_SESSION to v2.txt"
    fi
fi


if [ -n "$storage" ] && [ -d "$storage" ]; then
    echo "使用挂载目录: $storage"
    while true; do
        if [ -f "$storage/v1.txt" ] && [ -f "$storage/v2.txt" ]; then
            echo "从挂载目录中找到 v1.txt 和 v2.txt"
            cp "$storage/v1.txt" .
            cp "$storage/v2.txt" .
            v1_session=$(cat v1.txt)
            v2_session=$(cat v2.txt)
            export API_SESSION_V1="$v1_session"
            export API_SESSION="$v2_session"
            echo "环境变量已设置"
            echo "启动 ./tgsearch.x86_64 -I"
            ps -ef | grep '[t]gsearch.x86_64' | awk '{print $1}' | xargs --no-run-if-empty kill -9
            ps -ef | grep '[/]tmp/staticx-.*[/]app' | awk '{print $1}' | xargs --no-run-if-empty kill -9
            ./tgsearch.x86_64 -I
        else
            echo "挂载目录中没有 v1.txt 和 v2.txt，请执行二维码命令"
            sleep 10
        fi
    done
else
    echo "未使用挂载目录"
    while true; do
        if [ -f "v1.txt" ] && [ -f "v2.txt" ]; then
            echo "从当前目录中找到 v1.txt 和 v2.txt"
            v1_session=$(cat v1.txt)
            v2_session=$(cat v2.txt)
            export API_SESSION_V1="$v1_session"
            export API_SESSION="$v2_session"
            echo "环境变量已设置"
            echo "启动 ./tgsearch.x86_64 -I"
            ps -ef | grep '[t]gsearch.x86_64' | awk '{print $1}' | xargs --no-run-if-empty kill -9
            ps -ef | grep '[/]tmp/staticx-.*[/]app' | awk '{print $1}' | xargs --no-run-if-empty kill -9
            ./tgsearch.x86_64 -I
        else
            echo "当前目录中没有 v1.txt 和 v2.txt，请执行二维码命令"
            sleep 10
        fi
    done
fi
