// API代理配置
const API_HOST = process.env.NODE_ENV === 'production' 
  ? 'http://192.168.134.157' 
  : 'http://localhost';

module.exports = {
  // 用户服务
  "/u/": `${API_HOST}:8021`,
  // 商品服务
  "/g/": `${API_HOST}:8022`,
  // 订单服务
  "/o/": `${API_HOST}:8023`,
  // 用户操作服务
  "/up/": `${API_HOST}:8027`,
  // OSS服务
  "/oss/": `${API_HOST}:8029`
};
