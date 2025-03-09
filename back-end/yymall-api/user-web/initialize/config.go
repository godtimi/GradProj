package initialize

import (
	"fmt"
	"github.com/spf13/viper"
	"go.uber.org/zap"
	"yymall-api/user-web/global"
)

func GetEnvInfo(env string) bool {
	viper.AutomaticEnv()
	return viper.GetBool(env)
}

func InitConfig() {
	// 直接设置配置，不使用 Nacos
	global.ServerConfig = global.ServerConfig
	global.ServerConfig.Name = "user-web"
	
	// 设置 JWT 配置
	global.ServerConfig.JWTInfo.SigningKey = "yymall"
	
	// 设置服务端口
	global.ServerConfig.Port = 8021
	
	// 设置 Consul 配置
	global.ServerConfig.ConsulInfo.Host = "192.168.134.157"
	global.ServerConfig.ConsulInfo.Port = 8500
	
	// 设置用户服务配置
	global.ServerConfig.UserSrvInfo.Name = "user-srv"
	
	zap.S().Infof("配置信息: %v", global.ServerConfig)
}
