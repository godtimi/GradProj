package initialize

import (
	"yymall_srvs/goods_srv/global"

	"github.com/spf13/viper"
	"go.uber.org/zap"
)

func GetEnvInfo(env string) bool {
	viper.AutomaticEnv()
	return viper.GetBool(env)
}

func InitConfig() {
	// 直接设置配置，不使用 Nacos
	global.ServerConfig = global.ServerConfig
	global.ServerConfig.Name = "goods-srv"

	// 设置 MySQL 配置
	global.ServerConfig.MysqlInfo.Host = "192.168.134.157"
	global.ServerConfig.MysqlInfo.Port = 3306
	global.ServerConfig.MysqlInfo.Name = "yymall_goods"
	global.ServerConfig.MysqlInfo.User = "root"
	global.ServerConfig.MysqlInfo.Password = "root123"

	// 设置 Consul 配置
	global.ServerConfig.ConsulInfo.Host = "192.168.134.157"
	global.ServerConfig.ConsulInfo.Port = 8500

	// 设置 ES 配置
	global.ServerConfig.EsInfo.Host = "192.168.134.157"
	global.ServerConfig.EsInfo.Port = 9200

	zap.S().Infof("配置信息: %v", global.ServerConfig)
}
