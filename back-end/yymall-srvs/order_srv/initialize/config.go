package initialize

import (
	"yymall_srvs/order_srv/global"

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
	global.ServerConfig.Name = "order-srv"

	// 设置 MySQL 配置
	global.ServerConfig.MysqlInfo.Host = "192.168.134.157"
	global.ServerConfig.MysqlInfo.Port = 3306
	global.ServerConfig.MysqlInfo.Name = "yymall_order"
	global.ServerConfig.MysqlInfo.User = "root"
	global.ServerConfig.MysqlInfo.Password = "root123"

	// 设置 Consul 配置
	global.ServerConfig.ConsulInfo.Host = "192.168.134.157"
	global.ServerConfig.ConsulInfo.Port = 8500

	// 设置 RocketMQ 配置
	global.ServerConfig.RocketMQInfo.Host = "192.168.134.157"
	global.ServerConfig.RocketMQInfo.Port = 9876

	// 设置 Alipay 配置
	global.ServerConfig.AlipayInfo.AppID = "2021000122678896"
	global.ServerConfig.AlipayInfo.PrivateKey = "MIIEowIBAAKCAQEAjWYvMSL0Y5MJ3WkhQEw7cZ7Oa5TlTdJc6HPZT0QWDPyFbGt5K0k7qVk87KBpYsJJiM2Nh2p4W9wGHQIDAQAB"
	global.ServerConfig.AlipayInfo.AliPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjWYvMSL0Y5MJ3WkhQEw7cZ7Oa5TlTdJc6HPZT0QWDPyFbGt5K0k7qVk87KBpYsJJiM2Nh2p4W9wGHQIDAQAB"
	global.ServerConfig.AlipayInfo.NotifyURL = "http://192.168.134.157:8023/o/v1/pay/alipay/notify"
	global.ServerConfig.AlipayInfo.ReturnURL = "http://192.168.134.157:8023/o/v1/pay/alipay/return"

	// 设置 Goods 服务配置
	global.ServerConfig.GoodsSrvInfo.Name = "goods-srv"

	// 设置 Inventory 服务配置
	global.ServerConfig.InventorySrvInfo.Name = "inventory-srv"

	zap.S().Infof("配置信息: %v", global.ServerConfig)
}
