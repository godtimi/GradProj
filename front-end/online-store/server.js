const express = require("express");
const webpackDevMiddleware = require("webpack-dev-middleware");
const webpackHotMiddleware = require("webpack-hot-middleware");
const webpack = require("webpack");
const webpackConfig = require("./webpack.config");
const proxy = require("./proxy");
const path = require("path");
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const compiler = webpack(webpackConfig);
const PORT = process.env.PORT || 8089;

// 静态资源中间件
app.use(webpackDevMiddleware(compiler, {
	publicPath: '/',
	index: 'index.html',
	stats: {
		colors: true,
		chunks: false
	}
}));

// 热更新中间件
app.use(webpackHotMiddleware(compiler, {
	log: console.log
}));

// 设置API代理
Object.keys(proxy).forEach(context => {
	app.use(context, createProxyMiddleware({
		target: proxy[context],
		changeOrigin: true,
		pathRewrite: { [`^${context}`]: '' }
	}));
	console.log(`Proxy created: ${context} -> ${proxy[context]}`);
});

// 处理HTML5 history模式
app.use('*', (req, res, next) => {
	const filename = path.join(compiler.outputPath, 'index.html');
	compiler.outputFileSystem.readFile(filename, (err, result) => {
		if (err) {
			return next(err);
		}
		res.set('content-type', 'text/html');
		res.send(result);
		res.end();
	});
});

// 启动服务器
app.listen(PORT, function() {
	console.log(`Server is running at http://localhost:${PORT}`);
});