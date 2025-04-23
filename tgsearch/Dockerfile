# 使用Alpine 3.19作为基础镜像
FROM alpine:3.19

# 设置阿里云镜像源
RUN echo "https://mirrors.aliyun.com/alpine/v3.19/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/v3.19/community" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache libqrencode-tools bash sed grep zlib readline ncurses-libs coreutils acl attr utmps-libs skalibs && \
    rm -rf /var/cache/apk/* 

# 设置工作目录
WORKDIR /app

# 复制tgsearch.x86_64和run.sh
COPY tgsearch.x86_64 /app/tgsearch.x86_64
COPY run.sh /app/run.sh
COPY qr.sh /app/qr.sh

# 赋予执行权限
RUN chmod +x /app/tgsearch.x86_64 /app/run.sh /app/qr.sh

# 设置入口点
ENTRYPOINT ["/app/run.sh"]
