.PHONY: all build run clean docker help

# 默认目标
all: help

# 服务列表
SERVICES := user goods order inventory userop
API_SERVICES := user-web goods-web order-web userop-web

# 颜色定义
GREEN=\033[0;32m
YELLOW=\033[1;33m
NC=\033[0m # No Color

# 帮助信息
help:
	@echo "${YELLOW}云优商城微服务管理工具${NC}"
	@echo "${GREEN}可用命令:${NC}"
	@echo "  make build-all         - 编译所有微服务"
	@echo "  make build SERVICE=xxx - 编译指定微服务 (例如: make build SERVICE=user)"
	@echo "  make run-all           - 运行所有微服务"
	@echo "  make run SERVICE=xxx   - 运行指定微服务 (例如: make run SERVICE=user)"
	@echo "  make api-all           - 运行所有API网关"
	@echo "  make api SERVICE=xxx   - 运行指定API网关 (例如: make api SERVICE=user-web)"
	@echo "  make docker            - 使用Docker Compose启动所有服务"
	@echo "  make docker-build      - 构建所有Docker镜像"
	@echo "  make clean             - 清理编译文件"

# 编译所有微服务
build-all:
	@echo "${GREEN}编译所有微服务...${NC}"
	@for service in $(SERVICES); do \
		echo "${YELLOW}编译 $$service 服务...${NC}"; \
		cd $(CURDIR)/back-end/yymall-srvs/$${service}_srv && go build -o $${service}_srv .; \
	done
	@echo "${GREEN}所有微服务编译完成!${NC}"

# 编译指定微服务
build:
	@if [ -z "$(SERVICE)" ]; then \
		echo "${YELLOW}请指定服务名称，例如: make build SERVICE=user${NC}"; \
		exit 1; \
	fi
	@echo "${GREEN}编译 $(SERVICE) 服务...${NC}"
	@cd $(CURDIR)/back-end/yymall-srvs/$(SERVICE)_srv && go build -o $(SERVICE)_srv .
	@echo "${GREEN}$(SERVICE) 服务编译完成!${NC}"

# 运行所有微服务
run-all:
	@echo "${GREEN}启动所有微服务...${NC}"
	@for service in $(SERVICES); do \
		echo "${YELLOW}启动 $$service 服务...${NC}"; \
		cd $(CURDIR)/back-end/yymall-srvs/$${service}_srv && \
		nohup go run main.go > $${service}.log 2>&1 & echo $$! > $${service}.pid; \
	done
	@echo "${GREEN}所有微服务已启动!${NC}"

# 运行指定微服务
run:
	@if [ -z "$(SERVICE)" ]; then \
		echo "${YELLOW}请指定服务名称，例如: make run SERVICE=user${NC}"; \
		exit 1; \
	fi
	@echo "${GREEN}启动 $(SERVICE) 服务...${NC}"
	@cd $(CURDIR)/back-end/yymall-srvs/$(SERVICE)_srv && \
	nohup go run main.go > $(SERVICE).log 2>&1 & echo $$! > $(SERVICE).pid
	@echo "${GREEN}$(SERVICE) 服务已启动!${NC}"

# 运行所有API网关
api-all:
	@echo "${GREEN}启动所有API网关...${NC}"
	@for service in $(API_SERVICES); do \
		echo "${YELLOW}启动 $$service API...${NC}"; \
		cd $(CURDIR)/back-end/yymall-api/$${service} && \
		nohup go run main.go > $${service}.log 2>&1 & echo $$! > $${service}.pid; \
	done
	@echo "${GREEN}所有API网关已启动!${NC}"

# 运行指定API网关
api:
	@if [ -z "$(SERVICE)" ]; then \
		echo "${YELLOW}请指定API网关名称，例如: make api SERVICE=user-web${NC}"; \
		exit 1; \
	fi
	@echo "${GREEN}启动 $(SERVICE) API网关...${NC}"
	@cd $(CURDIR)/back-end/yymall-api/$(SERVICE) && \
	nohup go run main.go > $(SERVICE).log 2>&1 & echo $$! > $(SERVICE).pid
	@echo "${GREEN}$(SERVICE) API网关已启动!${NC}"

# 使用Docker Compose启动所有服务
docker:
	@echo "${GREEN}使用Docker Compose启动所有服务...${NC}"
	@docker-compose up -d
	@echo "${GREEN}所有服务已启动!${NC}"

# 构建所有Docker镜像
docker-build:
	@echo "${GREEN}构建所有Docker镜像...${NC}"
	@docker-compose build
	@echo "${GREEN}所有Docker镜像构建完成!${NC}"

# 清理编译文件
clean:
	@echo "${GREEN}清理编译文件...${NC}"
	@for service in $(SERVICES); do \
		rm -f $(CURDIR)/back-end/yymall-srvs/$${service}_srv/$${service}_srv; \
		rm -f $(CURDIR)/back-end/yymall-srvs/$${service}_srv/$${service}.log; \
		if [ -f $(CURDIR)/back-end/yymall-srvs/$${service}_srv/$${service}.pid ]; then \
			kill -9 `cat $(CURDIR)/back-end/yymall-srvs/$${service}_srv/$${service}.pid` 2>/dev/null || true; \
			rm -f $(CURDIR)/back-end/yymall-srvs/$${service}_srv/$${service}.pid; \
		fi; \
	done
	@for service in $(API_SERVICES); do \
		rm -f $(CURDIR)/back-end/yymall-api/$${service}/$${service}.log; \
		if [ -f $(CURDIR)/back-end/yymall-api/$${service}/$${service}.pid ]; then \
			kill -9 `cat $(CURDIR)/back-end/yymall-api/$${service}/$${service}.pid` 2>/dev/null || true; \
			rm -f $(CURDIR)/back-end/yymall-api/$${service}/$${service}.pid; \
		fi; \
	done
	@echo "${GREEN}清理完成!${NC}" 