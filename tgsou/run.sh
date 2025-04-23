#!/bin/sh

# 从 /proc/mounts 提取挂载点并赋值给变量 storage
storage=$(cat /proc/mounts | grep /dev/mapper/vg_lvm-pvc | awk '{print $2}')

if [ -n "$storage" ] && [ -d "$storage" ]; then
    # 检查并保存 API_SESSION_V1
    if [ -n "$API_SESSION_V1" ]; then
        echo "$API_SESSION_V1" > "$storage/193316_session_0.txt"
        echo "Saved API_SESSION_V1 to $storage/193316_session_0.txt"
    fi
else
    # 检查并保存API_SESSION_V1
    if [ -n "$API_SESSION_V1" ]; then
        echo "$API_SESSION_V1" > "193316_session_0.txt"
        echo "Saved API_SESSION_V1 to 193316_session_0.txt"
    fi
fi

if [ -z "$storage" ] || [ ! -d "$storage" ]; then
    echo "未使用存储"
    if ! ls *.txt >/dev/null 2>&1; then
        echo "未找到 session 文件，进入循环等待..."
        while true; do
            if ls *.txt >/dev/null 2>&1; then
                break
            else
                sleep 10
            fi
        done
    fi

    if ls *.txt >/dev/null 2>&1; then
        echo "找到 session 文件，检查 tgsou-linux 进程..."
        ps -ef | grep '[t]gsou-linux' | awk '{print $1}' | xargs --no-run-if-empty kill -9
        ps -ef | grep '[/]tmp/staticx-.*[/]app' | awk '{print $1}' | xargs --no-run-if-empty kill -9
        ./tgsou-linux
    fi
else
    echo "使用存储"
    if ls "$storage"/*.txt >/dev/null 2>&1; then
        cp -a "$storage"/*.txt .
        echo "从存储中找到 session 文件，启动 tgsou-linux 进程..."
        ./tgsou-linux
    else
        echo "存储中没有session文件"
        if ! ls *.txt >/dev/null 2>&1; then
            echo "未找到 session 文件，进入循环等待..."
            while true; do
                if ls *.txt >/dev/null 2>&1; then
                    cp -a *.txt "$storage"/
                    break
                else
                    sleep 10
                fi
            done
        fi

        if ls *.txt >/dev/null 2>&1; then
            echo "找到 session 文件，检查 tgsou-linux 进程..."
            ps -ef | grep '[t]gsou-linux' | awk '{print $1}' | xargs --no-run-if-empty kill -9
            ps -ef | grep '[/]tmp/staticx-.*[/]app' | awk '{print $1}' | xargs --no-run-if-empty kill -9
            ./tgsou-linux
        fi

    fi
fi
