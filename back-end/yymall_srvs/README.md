# MXShop 微服务

这是 MXShop 电商系统的微服务后端部分。本项目使用 Go 语言开发，采用微服务架构。

## 项目结构

```
yymall_srvs/
├── user_srv/       # 用户服务
├── goods_srv/      # 商品服务
├── order_srv/      # 订单服务
├── inventory_srv/  # 库存服务
└── userop_srv/     # 用户操作服务
```

## 技术栈

- Go 1.21+
- gRPC
- GORM
- Nacos (配置中心与服务发现)
- MySQL
- Redis
- RocketMQ
- Elasticsearch
- Jaeger (链路追踪)
- OpenTracing

## 环境要求

- Go 1.21+
- MySQL 5.7+
- Redis
- Nacos
- RocketMQ
- Elasticsearch
- Jaeger

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
# 分别进入各个服务目录运行
cd user_srv
go run main.go
```

## 服务说明

- user_srv: 用户服务，处理用户注册、登录等功能
- goods_srv: 商品服务，处理商品CRUD、分类等功能
- order_srv: 订单服务，处理订单创建、支付等功能
- inventory_srv: 库存服务，处理商品库存管理
- userop_srv: 用户操作服务，处理收藏、留言等功能

## 贡献指南

欢迎提交 Pull Request 或 Issue。

## 许可证

MIT License 