package initialize

import (
	"net/http"

	"yymall-api/user-web/middlewares"
	"yymall-api/user-web/router"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

func Routers() *gin.Engine {
	Router := gin.Default()
	Router.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"code":    http.StatusOK,
			"success": true,
			"message": "user-web service is healthy",
		})
	})

	//配置跨域
	Router.Use(middlewares.Cors())
	zap.S().Info("配置跨域中间件")

	ApiGroup := Router.Group("/u/v1")
	router.InitUserRouter(ApiGroup)
	zap.S().Info("用户路由初始化完成")

	router.InitBaseRouter(ApiGroup)
	zap.S().Info("基础路由初始化完成")

	return Router
}
