#!/bin/bash

# 设置颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Nacos 配置
NACOS_HOST="192.168.134.157"
NACOS_PORT="8848"
NACOS_NAMESPACE="public"
NACOS_USER="nacos"
NACOS_PASSWORD="nacos"
NACOS_GROUP="dev"

# 等待 Nacos 启动
echo -e "${YELLOW}等待 Nacos 启动...${NC}"
until curl -s -o /dev/null -w "%{http_code}" "http://${NACOS_HOST}:${NACOS_PORT}/nacos/" | grep -q "200"; do
  echo -e "${YELLOW}Nacos 未就绪，等待 5 秒...${NC}"
  sleep 5
done
echo -e "${GREEN}Nacos 已启动${NC}"

# 创建用户服务配置
echo -e "${YELLOW}创建用户服务配置...${NC}"
USER_CONFIG='{
  "name": "user-srv",
  "mysql": {
    "host": "192.168.134.157",
    "port": 3306,
    "db": "yymall_user",
    "user": "root",
    "password": "root123"
  },
  "consul": {
    "host": "192.168.134.157",
    "port": 8500
  }
}'

curl -X POST "http://${NACOS_HOST}:${NACOS_PORT}/nacos/v1/cs/configs" \
  -d "dataId=user-srv.json" \
  -d "group=${NACOS_GROUP}" \
  -d "content=${USER_CONFIG}" \
  -d "type=json" \
  -d "username=${NACOS_USER}" \
  -d "password=${NACOS_PASSWORD}"

echo -e "${GREEN}用户服务配置已创建${NC}"

# 创建商品服务配置
echo -e "${YELLOW}创建商品服务配置...${NC}"
GOODS_CONFIG='{
  "name": "goods-srv",
  "mysql": {
    "host": "192.168.134.157",
    "port": 3306,
    "db": "yymall_goods",
    "user": "root",
    "password": "root123"
  },
  "consul": {
    "host": "192.168.134.157",
    "port": 8500
  },
  "es": {
    "host": "192.168.134.157",
    "port": 9200
  }
}'

curl -X POST "http://${NACOS_HOST}:${NACOS_PORT}/nacos/v1/cs/configs" \
  -d "dataId=goods-srv.json" \
  -d "group=${NACOS_GROUP}" \
  -d "content=${GOODS_CONFIG}" \
  -d "type=json" \
  -d "username=${NACOS_USER}" \
  -d "password=${NACOS_PASSWORD}"

echo -e "${GREEN}商品服务配置已创建${NC}"

# 创建库存服务配置
echo -e "${YELLOW}创建库存服务配置...${NC}"
INVENTORY_CONFIG='{
  "name": "inventory-srv",
  "mysql": {
    "host": "192.168.134.157",
    "port": 3306,
    "db": "yymall_inventory",
    "user": "root",
    "password": "root123"
  },
  "consul": {
    "host": "192.168.134.157",
    "port": 8500
  }
}'

curl -X POST "http://${NACOS_HOST}:${NACOS_PORT}/nacos/v1/cs/configs" \
  -d "dataId=inventory-srv.json" \
  -d "group=${NACOS_GROUP}" \
  -d "content=${INVENTORY_CONFIG}" \
  -d "type=json" \
  -d "username=${NACOS_USER}" \
  -d "password=${NACOS_PASSWORD}"

echo -e "${GREEN}库存服务配置已创建${NC}"

# 创建订单服务配置
echo -e "${YELLOW}创建订单服务配置...${NC}"
ORDER_CONFIG='{
  "name": "order-srv",
  "mysql": {
    "host": "192.168.134.157",
    "port": 3306,
    "db": "yymall_order",
    "user": "root",
    "password": "root123"
  },
  "consul": {
    "host": "192.168.134.157",
    "port": 8500
  },
  "goods_srv": {
    "name": "goods-srv"
  },
  "inventory_srv": {
    "name": "inventory-srv"
  },
  "rocketmq": {
    "host": "192.168.134.157",
    "port": 9876
  },
  "alipay": {
    "app_id": "2021000122678896",
    "private_key": "MIIEowIBAAKCAQEAjWYvMSL0Y5MJ3WkhQEw7cZ7Oa5TlTdJc6HPZT0QWDPyFbGt5K0k7qVk87KBpYsJJiM2Nh2p4W9wGHQIDAQAB",
    "ali_public_key": "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjWYvMSL0Y5MJ3WkhQEw7cZ7Oa5TlTdJc6HPZT0QWDPyFbGt5K0k7qVk87KBpYsJJiM2Nh2p4W9wGHQIDAQAB",
    "notify_url": "http://192.168.134.157:8023/o/v1/pay/alipay/notify",
    "return_url": "http://192.168.134.157:8023/o/v1/pay/alipay/return"
  }
}'

curl -X POST "http://${NACOS_HOST}:${NACOS_PORT}/nacos/v1/cs/configs" \
  -d "dataId=order-srv.json" \
  -d "group=${NACOS_GROUP}" \
  -d "content=${ORDER_CONFIG}" \
  -d "type=json" \
  -d "username=${NACOS_USER}" \
  -d "password=${NACOS_PASSWORD}"

echo -e "${GREEN}订单服务配置已创建${NC}"

# 创建用户操作服务配置
echo -e "${YELLOW}创建用户操作服务配置...${NC}"
USEROP_CONFIG='{
  "name": "userop-srv",
  "mysql": {
    "host": "192.168.134.157",
    "port": 3306,
    "db": "yymall_userop",
    "user": "root",
    "password": "root123"
  },
  "consul": {
    "host": "192.168.134.157",
    "port": 8500
  },
  "goods_srv": {
    "name": "goods-srv"
  }
}'

curl -X POST "http://${NACOS_HOST}:${NACOS_PORT}/nacos/v1/cs/configs" \
  -d "dataId=userop-srv.json" \
  -d "group=${NACOS_GROUP}" \
  -d "content=${USEROP_CONFIG}" \
  -d "type=json" \
  -d "username=${NACOS_USER}" \
  -d "password=${NACOS_PASSWORD}"

echo -e "${GREEN}用户操作服务配置已创建${NC}"

# 创建用户 API 配置
echo -e "${YELLOW}创建用户 API 配置...${NC}"
USER_WEB_CONFIG='{
  "name": "user-web",
  "port": 8021,
  "user_srv": {
    "name": "user-srv"
  },
  "jwt": {
    "key": "yymall"
  },
  "consul": {
    "host": "192.168.134.157",
    "port": 8500
  }
}'

curl -X POST "http://${NACOS_HOST}:${NACOS_PORT}/nacos/v1/cs/configs" \
  -d "dataId=user-web.json" \
  -d "group=${NACOS_GROUP}" \
  -d "content=${USER_WEB_CONFIG}" \
  -d "type=json" \
  -d "username=${NACOS_USER}" \
  -d "password=${NACOS_PASSWORD}"

echo -e "${GREEN}用户 API 配置已创建${NC}"

# 创建商品 API 配置
echo -e "${YELLOW}创建商品 API 配置...${NC}"
GOODS_WEB_CONFIG='{
  "name": "goods-web",
  "port": 8022,
  "goods_srv": {
    "name": "goods-srv"
  },
  "jwt": {
    "key": "yymall"
  },
  "consul": {
    "host": "192.168.134.157",
    "port": 8500
  }
}'

curl -X POST "http://${NACOS_HOST}:${NACOS_PORT}/nacos/v1/cs/configs" \
  -d "dataId=goods-web.json" \
  -d "group=${NACOS_GROUP}" \
  -d "content=${GOODS_WEB_CONFIG}" \
  -d "type=json" \
  -d "username=${NACOS_USER}" \
  -d "password=${NACOS_PASSWORD}"

echo -e "${GREEN}商品 API 配置已创建${NC}"

# 创建订单 API 配置
echo -e "${YELLOW}创建订单 API 配置...${NC}"
ORDER_WEB_CONFIG='{
  "name": "order-web",
  "port": 8023,
  "order_srv": {
    "name": "order-srv"
  },
  "goods_srv": {
    "name": "goods-srv"
  },
  "inventory_srv": {
    "name": "inventory-srv"
  },
  "jwt": {
    "key": "yymall"
  },
  "consul": {
    "host": "192.168.134.157",
    "port": 8500
  }
}'

curl -X POST "http://${NACOS_HOST}:${NACOS_PORT}/nacos/v1/cs/configs" \
  -d "dataId=order-web.json" \
  -d "group=${NACOS_GROUP}" \
  -d "content=${ORDER_WEB_CONFIG}" \
  -d "type=json" \
  -d "username=${NACOS_USER}" \
  -d "password=${NACOS_PASSWORD}"

echo -e "${GREEN}订单 API 配置已创建${NC}"

# 创建 OSS API 配置
echo -e "${YELLOW}创建 OSS API 配置...${NC}"
OSS_WEB_CONFIG='{
  "name": "oss-web",
  "port": 8029,
  "jwt": {
    "key": "yymall"
  },
  "consul": {
    "host": "192.168.134.157",
    "port": 8500
  },
  "oss": {
    "key": "LTAI5tRYrPSMNKFRYZEDqbvs",
    "secret": "secret_key_here",
    "host": "https://oss-cn-hangzhou.aliyuncs.com",
    "callback_url": "http://192.168.134.157:8029/oss/v1/oss/callback",
    "upload_dir": "yymall/images"
  }
}'

curl -X POST "http://${NACOS_HOST}:${NACOS_PORT}/nacos/v1/cs/configs" \
  -d "dataId=oss-web.json" \
  -d "group=${NACOS_GROUP}" \
  -d "content=${OSS_WEB_CONFIG}" \
  -d "type=json" \
  -d "username=${NACOS_USER}" \
  -d "password=${NACOS_PASSWORD}"

echo -e "${GREEN}OSS API 配置已创建${NC}"

# 创建用户操作 API 配置
echo -e "${YELLOW}创建用户操作 API 配置...${NC}"
USEROP_WEB_CONFIG='{
  "name": "userop-web",
  "port": 8027,
  "userop_srv": {
    "name": "userop-srv"
  },
  "goods_srv": {
    "name": "goods-srv"
  },
  "jwt": {
    "key": "yymall"
  },
  "consul": {
    "host": "192.168.134.157",
    "port": 8500
  }
}'

curl -X POST "http://${NACOS_HOST}:${NACOS_PORT}/nacos/v1/cs/configs" \
  -d "dataId=userop-web.json" \
  -d "group=${NACOS_GROUP}" \
  -d "content=${USEROP_WEB_CONFIG}" \
  -d "type=json" \
  -d "username=${NACOS_USER}" \
  -d "password=${NACOS_PASSWORD}"

echo -e "${GREEN}用户操作 API 配置已创建${NC}"

echo -e "${GREEN}所有配置已创建完成${NC}" 