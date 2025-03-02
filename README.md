# GradProj
Go E-commerce Platform

## 技术栈
- 后端：Go 1.23.1
- 前端：Vue 2.7.16 + Element UI 2.15.14
- 数据库：MySQL, Redis
- 微服务：gRPC, Consul

## Documentation
[Document](https://godtimi.notion.site/docu)

## 配置说明

1. OSS配置
   - 复制示例配置文件：`cp back-end/yymall-api/oss-web/config-example.yaml back-end/yymall-api/oss-web/config.yaml`
   - 修改 `config.yaml` 中的配置信息：
     - 填入您的 AccessKey ID 和 Secret
     - 设置正确的 OSS bucket 访问域名
     - 配置回调 URL
     - 设置上传目录前缀

注意：请勿将包含实际密钥的配置文件提交到代码仓库中。

## 环境要求
- Go 1.23.1
- Node.js 18.0.0+
- npm 9.0.0+
- MySQL 8.0+
- Redis 6.0+
- Consul 1.14+
- Nacos 2.2+

## 部署说明
