package initialize

import (
	"github.com/spf13/viper"
	"go.uber.org/zap"
	"yymall_srvs/user_srv/global"
)

func GetEnvInfo(env string) bool {
	viper.AutomaticEnv()
	return viper.GetBool(env)
	//刚才设置的环境变量 想要生效 我们必须得重启goland
}

func InitConfig(configFile string) {
	v := viper.New()
	v.SetConfigFile(configFile)
	if err := v.ReadInConfig(); err != nil {
		panic(err)
	}
	if err := v.Unmarshal(&global.ServerConfig); err != nil {
		panic(err)
	}
	zap.S().Infof("配置信息: %v", global.ServerConfig)
}
