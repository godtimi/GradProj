module yymall_srvs

go 1.23.1

require (
	github.com/HdrHistogram/hdrhistogram-go v1.1.2 // indirect
	github.com/anaskhan96/go-password-encoder v0.0.0-20201010210601-c765b799fd72
	github.com/apache/rocketmq-client-go/v2 v2.1.2
	github.com/gin-gonic/gin v1.9.1
	github.com/go-redis/redis/v8 v8.11.5
	github.com/go-redsync/redsync/v4 v4.11.0
	github.com/golang/protobuf v1.5.3
	github.com/grpc-ecosystem/grpc-opentracing v0.0.0-20180507213350-8e809c8a8645
	github.com/hashicorp/consul/api v1.27.0
	github.com/mbobakov/grpc-consul-resolver v1.5.3
	github.com/nacos-group/nacos-sdk-go/v2 v2.2.5
	github.com/olivere/elastic/v7 v7.0.32
	github.com/opentracing/opentracing-go v1.2.0
	github.com/google/uuid v1.5.0 // 替换 satori/go.uuid
	github.com/spf13/viper v1.18.2
	github.com/stretchr/testify v1.8.4
	github.com/uber/jaeger-client-go v2.30.0+incompatible
	github.com/uber/jaeger-lib v2.4.1+incompatible // indirect
	go.uber.org/zap v1.26.0
	golang.org/x/crypto v0.18.0
	golang.org/x/net v0.20.0
	google.golang.org/grpc v1.60.1
	google.golang.org/protobuf v1.32.0
	gorm.io/driver/mysql v1.5.2
	gorm.io/gorm v1.25.5
)

// 添加替换指令，解决可能的兼容性问题
replace github.com/satori/go.uuid => github.com/google/uuid v1.5.0
