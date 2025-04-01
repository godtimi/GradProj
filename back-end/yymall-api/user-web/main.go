package main

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"
	"yymall-api/user-web/utils/register/consul"

	uuid "github.com/google/uuid"

	"github.com/gin-gonic/gin/binding"
	ut "github.com/go-playground/universal-translator"
	"github.com/go-playground/validator/v10"
	"github.com/spf13/viper"
	"go.uber.org/zap"

	"yymall-api/user-web/global"
	"yymall-api/user-web/initialize"
	myvalidator "yymall-api/user-web/validator"
)

func main() {
	//1. 初始化logger
	initialize.InitLogger()
	zap.S().Info("日志初始化完成")

	//2. 初始化配置文件
	initialize.InitConfig()
	zap.S().Info("配置文件初始化完成")

	//3. 初始化routers
	Router := initialize.Routers()
	zap.S().Info("路由初始化完成")

	//4. 初始化翻译
	if err := initialize.InitTrans("zh"); err != nil {
		zap.S().Errorf("翻译初始化失败: %s", err.Error())
		return
	}
	zap.S().Info("翻译初始化完成")

	//5. 初始化srv的连接
	initialize.InitSrvConn()
	zap.S().Info("服务连接初始化完成")

	viper.AutomaticEnv()
	//如果是本地开发环境端口号固定，线上环境启动获取端口号
	debug := viper.GetBool("MXSHOP_DEBUG")
	if !debug {
		global.ServerConfig.Port = 8021
	}

	//注册验证器
	if v, ok := binding.Validator.Engine().(*validator.Validate); ok {
		_ = v.RegisterValidation("mobile", myvalidator.ValidateMobile)
		_ = v.RegisterTranslation("mobile", global.Trans, func(ut ut.Translator) error {
			return ut.Add("mobile", "{0} 非法的手机号码!", true)
		}, func(ut ut.Translator, fe validator.FieldError) string {
			t, _ := ut.T("mobile", fe.Field())
			return t
		})
	}
	zap.S().Info("验证器注册完成")

	//服务注册
	register_client := consul.NewRegistryClient(global.ServerConfig.ConsulInfo.Host, global.ServerConfig.ConsulInfo.Port)
	serviceId := fmt.Sprintf("%s", uuid.New())
	err := register_client.Register(global.ServerConfig.Host, global.ServerConfig.Port, global.ServerConfig.Name, global.ServerConfig.Tags, serviceId)
	if err != nil {
		zap.S().Errorf("服务注册失败: %s", err.Error())
		return
	}
	zap.S().Info("服务注册完成")

	zap.S().Infof("启动服务器, 端口： %d", global.ServerConfig.Port)
	go func() {
		if err := Router.Run(fmt.Sprintf(":%d", global.ServerConfig.Port)); err != nil {
			zap.S().Errorf("启动失败: %s", err.Error())
		}
	}()

	//接收终止信号
	quit := make(chan os.Signal)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	<-quit
	if err = register_client.DeRegister(serviceId); err != nil {
		zap.S().Errorf("注销失败: %s", err.Error())
	} else {
		zap.S().Info("注销成功")
	}
}
