#!/bin/bash

# 重命名目录
echo "重命名目录..."
mv back-end/mxshop_srvs back-end/yymall_srvs
mv back-end/mxshop-api back-end/yymall-api

# 修改导入路径
echo "修改导入路径..."
find back-end/yymall_srvs -type f -name "*.go" -exec sed -i 's/mxshop_srvs/yymall_srvs/g' {} \;
find back-end/yymall-api -type f -name "*.go" -exec sed -i 's/mxshop-api/yymall-api/g' {} \;

# 修改 README.md 文件
echo "修改 README.md 文件..."
sed -i 's/mxshop_srvs/yymall_srvs/g' back-end/yymall_srvs/README.md
sed -i 's/mxshop-api/yymall-api/g' back-end/yymall-api/README.md
sed -i 's/mxshop-api/yymall-api/g' README.md
sed -i 's/mxshop_srvs/yymall_srvs/g' README.md

echo "项目重命名完成！" 