package initialize

import (
	"fmt"
	"github.com/spf13/viper"
	"go.uber.org/zap"
	"yymall_srvs/userop_srv/global"
)

func GetEnvInfo(env string) bool {
	viper.AutomaticEnv()
	return viper.GetBool(env)
}

func InitConfig(){
	// 直接设置配置，不使用 Nacos
	global.ServerConfig = global.ServerConfig
	global.ServerConfig.Name = "userop-srv"
	
	// 设置 MySQL 配置
	global.ServerConfig.MysqlInfo.Host = "192.168.134.157"
	global.ServerConfig.MysqlInfo.Port = 3306
	global.ServerConfig.MysqlInfo.Name = "yymall_userop"
	global.ServerConfig.MysqlInfo.User = "root"
	global.ServerConfig.MysqlInfo.Password = "root123"
	
	// 设置 Consul 配置
	global.ServerConfig.ConsulInfo.Host = "192.168.134.157"
	global.ServerConfig.ConsulInfo.Port = 8500
	
	// 设置 Goods 服务配置
	global.ServerConfig.GoodsSrvInfo.Name = "goods-srv"
	
	zap.S().Infof("配置信息: %v", global.ServerConfig)
}