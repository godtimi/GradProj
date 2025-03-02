# GradProj
Go E-commerce Platform

## 技术栈
- 后端：Go 1.23.1
- 前端：
  - 后台管理系统：Vue 2.7.16 + Element UI 2.15.14
  - 在线商城：Vue 2.7.16 + 原生CSS/SCSS
- 数据库：MySQL, Redis
- 微服务：gRPC, Consul

## Documentation
[Document](https://godtimi.notion.site/docu)

## 环境配置

### 方式一：使用Docker容器（推荐）

项目提供了Docker Compose配置，可以快速启动所有依赖服务。

#### 前提条件
- Docker 20.10+
- Docker Compose 2.0+
- Go 1.23.1

#### 启动服务
```bash
# 启动所有服务
./start_services.sh start

# 查看服务状态
./start_services.sh status

# 停止所有服务
./start_services.sh stop

# 重启所有服务
./start_services.sh restart
```

#### 服务访问地址
- Consul UI: http://localhost:8500
- Nacos UI: http://localhost:8848/nacos
- Jaeger UI: http://localhost:16686
- 前端应用: http://localhost:8080

### 方式二：手动安装

#### 1. 安装 Go 1.23.1
```bash
# 下载 Go 1.23.1
wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz

# 解压到 /usr/local
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz

# 设置环境变量
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
source ~/.profile

# 验证安装
go version
```

#### 2. 安装 Node.js 和 npm
```bash
# 使用 nvm 安装 Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc

# 安装 Node.js 18
nvm install 18
nvm use 18

# 验证安装
node -v
npm -v
```

#### 3. 安装 MySQL 8.0
```bash
# 安装 MySQL
sudo apt update
sudo apt install mysql-server-8.0

# 启动 MySQL
sudo systemctl start mysql
sudo systemctl enable mysql

# 配置 MySQL
sudo mysql_secure_installation
```

#### 4. 安装 Redis 6.0+
```bash
# 安装依赖
sudo apt install build-essential tcl

# 下载并编译 Redis
wget https://download.redis.io/releases/redis-6.2.14.tar.gz
tar xzf redis-6.2.14.tar.gz
cd redis-6.2.14
make

# 安装 Redis
sudo make install

# 配置 Redis 为服务
sudo ./utils/install_server.sh

# 验证安装
redis-cli ping
```

#### 5. 安装 Consul
```bash
# 下载 Consul
wget https://releases.hashicorp.com/consul/1.16.2/consul_1.16.2_linux_amd64.zip
unzip consul_1.16.2_linux_amd64.zip

# 移动到 PATH 目录
sudo mv consul /usr/local/bin/

# 验证安装
consul version

# 启动 Consul 开发模式
consul agent -dev
```

#### 6. 安装 Nacos
```bash
# 下载 Nacos
wget https://github.com/alibaba/nacos/releases/download/2.2.3/nacos-server-2.2.3.tar.gz
tar -xvf nacos-server-2.2.3.tar.gz

# 启动 Nacos
cd nacos/bin
./startup.sh -m standalone
```

#### 7. 安装 Jaeger (用于分布式追踪)
```bash
# 使用 Docker 安装 Jaeger
docker run -d --name jaeger \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -p 5775:5775/udp \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 14268:14268 \
  -p 14250:14250 \
  -p 9411:9411 \
  jaegertracing/all-in-one:1.49
```

## 配置说明

1. OSS配置
   - 复制示例配置文件：`cp back-end/yymall-api/oss-web/config-example.yaml back-end/yymall-api/oss-web/config.yaml`
   - 修改 `config.yaml` 中的配置信息：
     - 填入您的 AccessKey ID 和 Secret
     - 设置正确的 OSS bucket 访问域名
     - 配置回调 URL
     - 设置上传目录前缀

2. 数据库配置
   - 创建数据库：
     ```sql
     CREATE DATABASE yymall_user;
     CREATE DATABASE yymall_goods;
     CREATE DATABASE yymall_order;
     CREATE DATABASE yymall_userop;
     CREATE DATABASE yymall_inventory;
     ```
   - 导入数据库结构：
     ```bash
     # 导入用户服务数据库
     mysql -u root -p yymall_user < back-end/yymall_srvs/user_srv/model/user.sql
     # 导入商品服务数据库
     mysql -u root -p yymall_goods < back-end/yymall_srvs/goods_srv/model/goods.sql
     # 导入订单服务数据库
     mysql -u root -p yymall_order < back-end/yymall_srvs/order_srv/model/order.sql
     # 导入用户操作服务数据库
     mysql -u root -p yymall_userop < back-end/yymall_srvs/userop_srv/model/userop.sql
     # 导入库存服务数据库
     mysql -u root -p yymall_inventory < back-end/yymall_srvs/inventory_srv/model/inventory.sql
     ```

注意：请勿将包含实际密钥的配置文件提交到代码仓库中。

## 环境要求
- Go 1.23.1
- Node.js 18.0.0+
- npm 9.0.0+
- MySQL 8.0+
- Redis 6.0+
- Consul 1.14+
- Nacos 2.2+

## 项目启动

### 1. 启动后端服务
```bash
# 启动用户服务
cd back-end/yymall_srvs/user_srv
go run main.go

# 启动商品服务
cd back-end/yymall_srvs/goods_srv
go run main.go

# 启动订单服务
cd back-end/yymall_srvs/order_srv
go run main.go

# 启动用户操作服务
cd back-end/yymall_srvs/userop_srv
go run main.go

# 启动库存服务
cd back-end/yymall_srvs/inventory_srv
go run main.go
```

### 2. 启动API网关
```bash
# 启动用户API
cd back-end/yymall-api/user-web
go run main.go

# 启动商品API
cd back-end/yymall-api/goods-web
go run main.go

# 启动订单API
cd back-end/yymall-api/order-web
go run main.go

# 启动OSS API
cd back-end/yymall-api/oss-web
go run main.go

# 启动用户操作API
cd back-end/yymall-api/userop-web
go run main.go
```

### 3. 启动前端
```bash
# 启动后台管理系统
cd front-end/mall-master
npm install
npm run dev

# 启动在线商城
cd front-end/online-store
npm install
npm run dev
```

## 代码适配说明

由于项目依赖版本升级，可能需要对代码进行一些调整：

### 1. Gin框架升级 (v1.6.3 -> v1.9.1)
- 中间件API可能有变化，需要检查中间件的使用方式
- 路由注册方式保持兼容，无需修改
- 请求和响应处理方式保持兼容，无需修改

### 2. JWT库替换 (dgrijalva/jwt-go -> golang-jwt/jwt/v5)
- 需要更新导入路径
- 部分API可能有变化，如Token解析方法

### 3. UUID库替换 (satori/go.uuid -> google/uuid)
- 需要更新导入路径
- 生成UUID的方法有所不同

### 4. gRPC升级 (v1.32.0 -> v1.60.1)
- 大部分API保持兼容，无需修改
- 如有使用高级特性，可能需要调整

### 5. Nacos SDK升级 (v1.0.0 -> v2.2.5)
- 导入路径变更为 github.com/nacos-group/nacos-sdk-go/v2
- 客户端初始化方法可能有变化

## 部署说明

### 容器化部署
推荐使用Docker和Docker Compose进行部署，详见上方的"使用Docker容器"部分。

### 手动部署
按照上述步骤手动安装和配置各个组件，然后启动各个服务。
