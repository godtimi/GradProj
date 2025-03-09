import axios from 'axios';
import store from '../store/store';
import router from '../router';

// 创建axios实例
const service = axios.create({
  timeout: 15000, // 请求超时时间
  withCredentials: true // 跨域请求时发送cookies
});

// 请求拦截器
service.interceptors.request.use(
  config => {
    // 如果存在token，则每个请求都带上token
    if (store.state.userInfo.token) {
      config.headers["Authorization"] = `JWT ${store.state.userInfo.token}`;
      config.headers["x-token"] = `${store.state.userInfo.token}`;
    }
    return config;
  },
  error => {
    console.error('请求错误:', error);
    return Promise.reject(error);
  }
);

// 响应拦截器
service.interceptors.response.use(
  response => {
    const res = response.data;
    // 如果返回的状态码不是200，说明请求出错
    if (response.status !== 200) {
      console.error('请求错误:', res.message || '未知错误');
      return Promise.reject(new Error(res.message || '未知错误'));
    } else {
      return res;
    }
  },
  error => {
    if (error.response) {
      switch (error.response.status) {
        case 401:
          // 未登录或token过期
          console.log('未登录或token过期');
          store.commit('LOGOUT');
          router.replace({
            path: '/login',
            query: { redirect: router.currentRoute.fullPath }
          });
          break;
        case 403:
          console.log('没有操作权限');
          break;
        case 500:
          console.log('服务器错误');
          break;
        default:
          console.log(`未知错误: ${error.response.status}`);
      }
    } else {
      console.log('网络错误，请检查您的网络连接');
    }
    return Promise.reject(error);
  }
);

export default service; 