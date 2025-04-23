FROM alpine:3.19

# 创建 app 目录
RUN mkdir -p /app

# 复制 tgsou-linux 和 run.sh 到容器
COPY tgsou-linux /app/tgsou-linux
COPY run.sh /app/run.sh

# 设置工作目录
WORKDIR /app

# 明确设置可执行权限
RUN chmod +x /app/tgsou-linux /app/run.sh

# 使用 run.sh 作为入口点
ENTRYPOINT ["/app/run.sh"]
