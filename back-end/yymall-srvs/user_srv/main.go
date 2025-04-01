package main

import (
	"flag"
	"fmt"
	"net"
	"os"
	"os/signal"
	"syscall"
	"yymall_srvs/user_srv/global"
	"yymall_srvs/user_srv/handler"
	"yymall_srvs/user_srv/initialize"
	"yymall_srvs/user_srv/proto"

	"github.com/hashicorp/consul/api"
	"github.com/nacos-group/nacos-sdk-go/inner/uuid"
	"go.uber.org/zap"
	"google.golang.org/grpc"
	"google.golang.org/grpc/health"
	"google.golang.org/grpc/health/grpc_health_v1"
)

func main() {
	Debug := flag.Bool("debug", true, "是否使用debug模式")
	flag.Parse()

	//初始化
	initialize.InitLogger()
	if *Debug {
		initialize.InitConfig("config-debug.yaml")
	} else {
		initialize.InitConfig("config-pro.yaml")
	}
	initialize.InitDB()
	zap.S().Info(global.ServerConfig)

	flag.Parse()
	zap.S().Info("host: ", global.ServerConfig.Host)
	zap.S().Info("port: ", global.ServerConfig.Port)

	server := grpc.NewServer()
	proto.RegisterUserServer(server, &handler.UserServer{})
	lis, err := net.Listen("tcp", fmt.Sprintf("%s:%d", global.ServerConfig.Host, global.ServerConfig.Port))
	if err != nil {
		panic("failed to listen:" + err.Error())
	}
	//注册服务健康检查
	grpc_health_v1.RegisterHealthServer(server, health.NewServer())

	//服务注册
	//1. 初始化consul配置
	cfg := api.DefaultConfig()
	cfg.Address = fmt.Sprintf("%s:%d", global.ServerConfig.ConsulInfo.Host,
		global.ServerConfig.ConsulInfo.Port)
	//2. 创建client
	client, err := api.NewClient(cfg)
	if err != nil {
		panic(err)
	}

	//生成对应的检查对象
	check := &api.AgentServiceCheck{
		GRPC:                           fmt.Sprintf("%s:%d", global.ServerConfig.Host, global.ServerConfig.Port),
		Timeout:                        "5s",
		Interval:                       "5s",
		DeregisterCriticalServiceAfter: "15s",
	}

	//生成注册对象
	registration := new(api.AgentServiceRegistration)
	registration.Name = global.ServerConfig.Name
	id, err := uuid.NewV4()
	if err != nil {
		panic(err)
	}
	serviceID := id.String()

	registration.ID = serviceID
	registration.Port = global.ServerConfig.Port
	registration.Tags = []string{"yymall", "user", "srv"}
	registration.Address = global.ServerConfig.Host
	registration.Check = check

	err = client.Agent().ServiceRegister(registration)
	if err != nil {
		panic(err)
	}

	go func() {
		err = server.Serve(lis)
		if err != nil {
			panic("failed to start grpc:" + err.Error())
		}
	}()

	//接收终止信号
	quit := make(chan os.Signal)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	<-quit
	if err = client.Agent().ServiceDeregister(serviceID); err != nil {
		zap.S().Errorf("注销服务失败: %v", err)
	}
	zap.S().Info("服务已成功注销")
}
