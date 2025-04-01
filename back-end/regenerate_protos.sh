#!/bin/bash

# 设置错误时退出
set -e

# 设置颜色输出
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # 恢复默认颜色

# 日志函数
log_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# 当前已在项目根目录
cd "$(dirname "$0")"

log_info "检查和安装兼容的 protoc 插件..."
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

log_info "开始检查和生成所有 proto 文件..."

# 查找所有 proto 文件（排除测试文件）
find . -name "*.proto" | grep -v "test/" | while read proto_file; do
  proto_dir=$(dirname "$proto_file")
  proto_name=$(basename "$proto_file" .proto)
  pb_go="${proto_dir}/${proto_name}.pb.go"
  grpc_pb_go="${proto_dir}/${proto_name}_grpc.pb.go"
  
  # 检查是否缺少生成的文件
  if [ ! -f "$pb_go" ] || [ ! -f "$grpc_pb_go" ]; then
    log_warn "检测到缺少生成文件: $proto_file"
    
    # 删除可能存在的不完整文件
    rm -f "$pb_go" "$grpc_pb_go"
    
    log_info "正在生成: $proto_file"
    
    # 重新生成
    if protoc --go_out=. \
           --go_opt=paths=source_relative \
           --go-grpc_out=. \
           --go-grpc_opt=paths=source_relative \
           --proto_path=. \
           "$proto_file"; then
      log_success "成功生成: $proto_file"
    else
      log_error "生成失败: $proto_file"
    fi
  else
    # 检查生成的文件是否比 proto 文件旧
    proto_time=$(stat -c %Y "$proto_file")
    pb_time=$(stat -c %Y "$pb_go")
    grpc_time=$(stat -c %Y "$grpc_pb_go")
    
    if [ "$proto_time" -gt "$pb_time" ] || [ "$proto_time" -gt "$grpc_time" ]; then
      log_warn "检测到 proto 文件有更新: $proto_file"
      
      # 删除旧的生成文件
      rm -f "$pb_go" "$grpc_pb_go"
      
      log_info "正在重新生成: $proto_file"
      
      # 重新生成
      if protoc --go_out=. \
             --go_opt=paths=source_relative \
             --go-grpc_out=. \
             --go-grpc_opt=paths=source_relative \
             --proto_path=. \
             "$proto_file"; then
        log_success "成功重新生成: $proto_file"
      else
        log_error "重新生成失败: $proto_file"
      fi
    else
      log_info "已存在且为最新: $proto_file"
    fi
  fi
done

log_success "所有 proto 文件检查和生成完成"

# 显示生成结果统计
total_proto=$(find . -name "*.proto" | grep -v "test/" | wc -l)
total_pb=$(find . -name "*.pb.go" | grep -v "test/" | wc -l)
total_grpc=$(find . -name "*_grpc.pb.go" | grep -v "test/" | wc -l)

log_info "统计信息:"
log_info "- 总共 proto 文件: $total_proto"
log_info "- 生成的 .pb.go 文件: $total_pb"
log_info "- 生成的 _grpc.pb.go 文件: $total_grpc"

if [ "$total_proto" -eq "$((total_grpc))" ]; then
  log_success "所有 proto 文件都已成功生成"
else
  log_warn "有些 proto 文件可能未成功生成，请检查日志"
fi 