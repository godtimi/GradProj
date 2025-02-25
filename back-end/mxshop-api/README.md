# MXShop API 服务

这是 MXShop 电商系统的 API 网关服务部分。本项目使用 Go 语言开发，采用微服务架构。

## 项目结构

```
mxshop-api/
├── user-web/      # 用户服务API
├── goods-web/     # 商品服务API
├── order-web/     # 订单服务API
├── userop-web/    # 用户操作服务API
└── oss-web/       # 对象存储服务API
```

## 技术栈

- Go 1.21+
- gRPC
- Gin Framework
- Nacos (配置中心与服务发现)
- JWT
- Redis
- Sentinel (限流)
- Jaeger (链路追踪)
- OpenTracing

## 环境要求

- Go 1.21+
- Redis
- Nacos
- MySQL
- Jaeger
- RocketMQ

## 快速开始

1. 安装依赖
```bash
go mod tidy
```

2. 配置环境
- 复制 `config-debug.yaml.example` 到 `config-debug.yaml`
- 修改配置文件中的相关配置

3. 运行服务
```bash
go run main.go
```

## 接口文档

API 文档位于各个服务的 `api/` 目录下。

## 贡献指南

欢迎提交 Pull Request 或 Issue。

## 许可证

MIT License 