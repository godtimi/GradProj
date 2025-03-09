# 使用Go 1.23作为基础镜像
FROM golang:1.23

# 设置Go环境变量
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct

# 设置工作目录
WORKDIR /app

# 复制go.mod和go.sum文件
COPY go.mod go.sum ./

# 下载依赖
RUN go mod download

# 复制源代码
COPY . .

# 编译
RUN go build -o goods_srv .

# 暴露gRPC端口
EXPOSE 50052

# 运行服务
CMD ["./goods_srv"] 