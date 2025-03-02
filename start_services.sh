#!/bin/bash

# 设置颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 项目根目录
PROJECT_ROOT=$(pwd)

# 启动Docker容器服务
start_docker_services() {
  echo -e "${YELLOW}启动Docker容器服务...${NC}"
  docker-compose up -d
  if [ $? -ne 0 ]; then
    echo -e "${RED}启动Docker容器服务失败${NC}"
    exit 1
  fi
  echo -e "${GREEN}Docker容器服务启动成功${NC}"
  echo -e "${YELLOW}等待服务就绪...${NC}"
  sleep 10
}

# 启动后端微服务
start_backend_services() {
  echo -e "${YELLOW}启动后端微服务...${NC}"
  
  # 启动用户服务
  echo -e "${YELLOW}启动用户服务...${NC}"
  cd $PROJECT_ROOT/back-end/yymall_srvs/user_srv
  nohup go run main.go > user_srv.log 2>&1 &
  echo $! > user_srv.pid
  
  # 等待服务启动
  sleep 5
  
  # 启动商品服务
  echo -e "${YELLOW}启动商品服务...${NC}"
  cd $PROJECT_ROOT/back-end/yymall_srvs/goods_srv
  nohup go run main.go > goods_srv.log 2>&1 &
  echo $! > goods_srv.pid
  
  # 等待服务启动
  sleep 5
  
  # 启动库存服务
  echo -e "${YELLOW}启动库存服务...${NC}"
  cd $PROJECT_ROOT/back-end/yymall_srvs/inventory_srv
  nohup go run main.go > inventory_srv.log 2>&1 &
  echo $! > inventory_srv.pid
  
  # 等待服务启动
  sleep 5
  
  # 启动订单服务
  echo -e "${YELLOW}启动订单服务...${NC}"
  cd $PROJECT_ROOT/back-end/yymall_srvs/order_srv
  nohup go run main.go > order_srv.log 2>&1 &
  echo $! > order_srv.pid
  
  # 等待服务启动
  sleep 5
  
  # 启动用户操作服务
  echo -e "${YELLOW}启动用户操作服务...${NC}"
  cd $PROJECT_ROOT/back-end/yymall_srvs/userop_srv
  nohup go run main.go > userop_srv.log 2>&1 &
  echo $! > userop_srv.pid
  
  # 等待服务启动
  sleep 5
  
  echo -e "${GREEN}后端微服务启动成功${NC}"
}

# 启动API网关
start_api_gateway() {
  echo -e "${YELLOW}启动API网关...${NC}"
  
  # 启动用户API
  echo -e "${YELLOW}启动用户API...${NC}"
  cd $PROJECT_ROOT/back-end/yymall-api/user-web
  nohup go run main.go > user_web.log 2>&1 &
  echo $! > user_web.pid
  
  # 等待服务启动
  sleep 3
  
  # 启动商品API
  echo -e "${YELLOW}启动商品API...${NC}"
  cd $PROJECT_ROOT/back-end/yymall-api/goods-web
  nohup go run main.go > goods_web.log 2>&1 &
  echo $! > goods_web.pid
  
  # 等待服务启动
  sleep 3
  
  # 启动订单API
  echo -e "${YELLOW}启动订单API...${NC}"
  cd $PROJECT_ROOT/back-end/yymall-api/order-web
  nohup go run main.go > order_web.log 2>&1 &
  echo $! > order_web.pid
  
  # 等待服务启动
  sleep 3
  
  # 启动OSS API
  echo -e "${YELLOW}启动OSS API...${NC}"
  cd $PROJECT_ROOT/back-end/yymall-api/oss-web
  nohup go run main.go > oss_web.log 2>&1 &
  echo $! > oss_web.pid
  
  # 等待服务启动
  sleep 3
  
  # 启动用户操作API
  echo -e "${YELLOW}启动用户操作API...${NC}"
  cd $PROJECT_ROOT/back-end/yymall-api/userop-web
  nohup go run main.go > userop_web.log 2>&1 &
  echo $! > userop_web.pid
  
  echo -e "${GREEN}API网关启动成功${NC}"
}

# 启动前端
start_frontend() {
  echo -e "${YELLOW}启动前端...${NC}"
  
  # 启动后台管理系统
  echo -e "${YELLOW}启动后台管理系统...${NC}"
  cd $PROJECT_ROOT/front-end/mall-master
  
  # 安装依赖
  if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}安装后台管理系统依赖...${NC}"
    npm install
  fi
  
  # 启动开发服务器
  nohup npm run dev > admin_frontend.log 2>&1 &
  echo $! > admin_frontend.pid
  
  # 启动在线商城
  echo -e "${YELLOW}启动在线商城...${NC}"
  cd $PROJECT_ROOT/front-end/online-store
  
  # 安装依赖
  if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}安装在线商城依赖...${NC}"
    npm install
  fi
  
  # 启动开发服务器
  nohup npm run dev > store_frontend.log 2>&1 &
  echo $! > store_frontend.pid
  
  echo -e "${GREEN}前端启动成功${NC}"
}

# 显示服务状态
show_status() {
  echo -e "${GREEN}服务状态:${NC}"
  echo -e "${YELLOW}Docker容器:${NC}"
  docker-compose ps
  
  echo -e "\n${YELLOW}后端微服务:${NC}"
  ps -ef | grep "go run main.go" | grep -v grep
  
  echo -e "\n${YELLOW}前端服务:${NC}"
  ps -ef | grep "npm run dev" | grep -v grep
  
  echo -e "\n${YELLOW}服务访问地址:${NC}"
  echo -e "Consul UI: ${GREEN}http://localhost:8500${NC}"
  echo -e "Nacos UI: ${GREEN}http://localhost:8848/nacos${NC}"
  echo -e "Jaeger UI: ${GREEN}http://localhost:16686${NC}"
  echo -e "后台管理系统: ${GREEN}http://localhost:8080${NC}"
  echo -e "在线商城: ${GREEN}http://localhost:8081${NC}"
}

# 停止所有服务
stop_services() {
  echo -e "${YELLOW}停止所有服务...${NC}"
  
  # 停止前端
  if [ -f "$PROJECT_ROOT/front-end/mall-master/admin_frontend.pid" ]; then
    kill -9 $(cat $PROJECT_ROOT/front-end/mall-master/admin_frontend.pid)
    rm $PROJECT_ROOT/front-end/mall-master/admin_frontend.pid
  fi
  
  if [ -f "$PROJECT_ROOT/front-end/online-store/store_frontend.pid" ]; then
    kill -9 $(cat $PROJECT_ROOT/front-end/online-store/store_frontend.pid)
    rm $PROJECT_ROOT/front-end/online-store/store_frontend.pid
  fi
  
  # 停止API网关
  for service in user goods order oss userop; do
    if [ -f "$PROJECT_ROOT/back-end/yymall-api/${service}-web/${service}_web.pid" ]; then
      kill -9 $(cat $PROJECT_ROOT/back-end/yymall-api/${service}-web/${service}_web.pid)
      rm $PROJECT_ROOT/back-end/yymall-api/${service}-web/${service}_web.pid
    fi
  done
  
  # 停止后端微服务
  for service in user goods inventory order userop; do
    if [ -f "$PROJECT_ROOT/back-end/yymall_srvs/${service}_srv/${service}_srv.pid" ]; then
      kill -9 $(cat $PROJECT_ROOT/back-end/yymall_srvs/${service}_srv/${service}_srv.pid)
      rm $PROJECT_ROOT/back-end/yymall_srvs/${service}_srv/${service}_srv.pid
    fi
  done
  
  # 停止Docker容器
  docker-compose down
  
  echo -e "${GREEN}所有服务已停止${NC}"
}

# 主函数
main() {
  case "$1" in
    start)
      start_docker_services
      start_backend_services
      start_api_gateway
      start_frontend
      show_status
      ;;
    stop)
      stop_services
      ;;
    restart)
      stop_services
      sleep 5
      start_docker_services
      start_backend_services
      start_api_gateway
      start_frontend
      show_status
      ;;
    status)
      show_status
      ;;
    *)
      echo -e "用法: $0 {start|stop|restart|status}"
      exit 1
      ;;
  esac
}

# 执行主函数
main "$@" 