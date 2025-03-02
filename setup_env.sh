#!/bin/bash

# 设置颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}开始配置YY商城开发环境...${NC}"

# 检查操作系统
OS=$(uname -s)
if [ "$OS" != "Linux" ]; then
  echo -e "${RED}此脚本仅支持Linux系统${NC}"
  exit 1
fi

# 创建日志文件
LOG_FILE="setup_env.log"
touch $LOG_FILE

# 安装基础工具
echo -e "${YELLOW}安装基础工具...${NC}"
sudo apt update && sudo apt install -y wget curl git unzip build-essential tcl >> $LOG_FILE 2>&1
if [ $? -ne 0 ]; then
  echo -e "${RED}安装基础工具失败，请查看日志文件${NC}"
  exit 1
fi
echo -e "${GREEN}基础工具安装完成${NC}"

# 安装 Go 1.23.1
echo -e "${YELLOW}安装 Go 1.23.1...${NC}"
if command -v go &> /dev/null && [ "$(go version | grep -o '1.23.1')" == "1.23.1" ]; then
  echo -e "${GREEN}Go 1.23.1 已安装${NC}"
else
  wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz -O /tmp/go1.23.1.linux-amd64.tar.gz >> $LOG_FILE 2>&1
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf /tmp/go1.23.1.linux-amd64.tar.gz >> $LOG_FILE 2>&1
  
  # 设置环境变量
  if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" ~/.profile; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
  fi
  source ~/.profile
  
  # 验证安装
  if command -v go &> /dev/null; then
    echo -e "${GREEN}Go 1.23.1 安装成功: $(go version)${NC}"
  else
    echo -e "${RED}Go 1.23.1 安装失败${NC}"
    exit 1
  fi
fi

# 安装 Node.js 和 npm
echo -e "${YELLOW}安装 Node.js 和 npm...${NC}"
if command -v node &> /dev/null && [ "$(node -v | grep -o 'v18')" == "v18" ]; then
  echo -e "${GREEN}Node.js 18 已安装${NC}"
else
  # 安装 nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash >> $LOG_FILE 2>&1
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  
  # 安装 Node.js 18
  nvm install 18 >> $LOG_FILE 2>&1
  nvm use 18 >> $LOG_FILE 2>&1
  
  # 验证安装
  if command -v node &> /dev/null; then
    echo -e "${GREEN}Node.js 安装成功: $(node -v)${NC}"
    echo -e "${GREEN}npm 安装成功: $(npm -v)${NC}"
  else
    echo -e "${RED}Node.js 安装失败${NC}"
    exit 1
  fi
fi

# 安装 MySQL 8.0
echo -e "${YELLOW}安装 MySQL 8.0...${NC}"
if command -v mysql &> /dev/null; then
  echo -e "${GREEN}MySQL 已安装: $(mysql --version)${NC}"
else
  sudo apt install -y mysql-server-8.0 >> $LOG_FILE 2>&1
  sudo systemctl start mysql >> $LOG_FILE 2>&1
  sudo systemctl enable mysql >> $LOG_FILE 2>&1
  
  echo -e "${GREEN}MySQL 安装成功${NC}"
  echo -e "${YELLOW}请手动运行 sudo mysql_secure_installation 完成 MySQL 安全配置${NC}"
fi

# 安装 Redis 6.0+
echo -e "${YELLOW}安装 Redis...${NC}"
if command -v redis-server &> /dev/null; then
  echo -e "${GREEN}Redis 已安装: $(redis-server --version)${NC}"
else
  wget https://download.redis.io/releases/redis-6.2.14.tar.gz -O /tmp/redis-6.2.14.tar.gz >> $LOG_FILE 2>&1
  tar xzf /tmp/redis-6.2.14.tar.gz -C /tmp >> $LOG_FILE 2>&1
  cd /tmp/redis-6.2.14
  make >> $LOG_FILE 2>&1
  sudo make install >> $LOG_FILE 2>&1
  
  echo -e "${GREEN}Redis 安装成功${NC}"
  echo -e "${YELLOW}请手动运行 sudo ./utils/install_server.sh 配置 Redis 服务${NC}"
fi

# 安装 Consul
echo -e "${YELLOW}安装 Consul...${NC}"
if command -v consul &> /dev/null; then
  echo -e "${GREEN}Consul 已安装: $(consul version)${NC}"
else
  wget https://releases.hashicorp.com/consul/1.16.2/consul_1.16.2_linux_amd64.zip -O /tmp/consul.zip >> $LOG_FILE 2>&1
  unzip /tmp/consul.zip -d /tmp >> $LOG_FILE 2>&1
  sudo mv /tmp/consul /usr/local/bin/ >> $LOG_FILE 2>&1
  
  # 验证安装
  if command -v consul &> /dev/null; then
    echo -e "${GREEN}Consul 安装成功: $(consul version)${NC}"
  else
    echo -e "${RED}Consul 安装失败${NC}"
    exit 1
  fi
fi

# 安装 Nacos
echo -e "${YELLOW}安装 Nacos...${NC}"
if [ -d "$HOME/nacos" ]; then
  echo -e "${GREEN}Nacos 已安装${NC}"
else
  wget https://github.com/alibaba/nacos/releases/download/2.2.3/nacos-server-2.2.3.tar.gz -O /tmp/nacos.tar.gz >> $LOG_FILE 2>&1
  tar -xvf /tmp/nacos.tar.gz -C $HOME >> $LOG_FILE 2>&1
  
  echo -e "${GREEN}Nacos 安装成功${NC}"
  echo -e "${YELLOW}启动 Nacos: cd $HOME/nacos/bin && ./startup.sh -m standalone${NC}"
fi

# 检查 Docker
echo -e "${YELLOW}检查 Docker...${NC}"
if command -v docker &> /dev/null; then
  echo -e "${GREEN}Docker 已安装: $(docker --version)${NC}"
else
  echo -e "${YELLOW}安装 Docker...${NC}"
  curl -fsSL https://get.docker.com -o /tmp/get-docker.sh >> $LOG_FILE 2>&1
  sudo sh /tmp/get-docker.sh >> $LOG_FILE 2>&1
  sudo usermod -aG docker $USER >> $LOG_FILE 2>&1
  
  # 验证安装
  if command -v docker &> /dev/null; then
    echo -e "${GREEN}Docker 安装成功: $(docker --version)${NC}"
  else
    echo -e "${RED}Docker 安装失败，请手动安装${NC}"
  fi
fi

# 创建数据库
echo -e "${YELLOW}创建数据库...${NC}"
echo -e "${YELLOW}请输入MySQL root密码:${NC}"
read -s MYSQL_PASSWORD

# 创建数据库
mysql -u root -p$MYSQL_PASSWORD -e "
CREATE DATABASE IF NOT EXISTS yymall_user;
CREATE DATABASE IF NOT EXISTS yymall_goods;
CREATE DATABASE IF NOT EXISTS yymall_order;
CREATE DATABASE IF NOT EXISTS yymall_userop;
CREATE DATABASE IF NOT EXISTS yymall_inventory;
" >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
  echo -e "${GREEN}数据库创建成功${NC}"
else
  echo -e "${RED}数据库创建失败，请检查MySQL密码或手动创建${NC}"
fi

# 配置项目
echo -e "${YELLOW}配置项目...${NC}"

# 复制示例配置文件
if [ -f "back-end/yymall-api/oss-web/config-example.yaml" ]; then
  cp back-end/yymall-api/oss-web/config-example.yaml back-end/yymall-api/oss-web/config.yaml
  echo -e "${GREEN}OSS配置文件已创建，请修改配置信息${NC}"
else
  echo -e "${RED}OSS示例配置文件不存在${NC}"
fi

echo -e "${GREEN}环境配置完成！${NC}"
echo -e "${YELLOW}请按照README.md中的说明启动项目${NC}"
echo -e "${YELLOW}如需启动Jaeger，请运行:${NC}"
echo -e "docker run -d --name jaeger \\
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \\
  -p 5775:5775/udp \\
  -p 6831:6831/udp \\
  -p 6832:6832/udp \\
  -p 5778:5778 \\
  -p 16686:16686 \\
  -p 14268:14268 \\
  -p 14250:14250 \\
  -p 9411:9411 \\
  jaegertracing/all-in-one:1.49" 