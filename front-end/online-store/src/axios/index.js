//引入vue
import Vue from 'vue';
import axios from 'axios';

//全局状态控制引入
import store from '../store/store';

import * as types from '../store/mutation-types';
import router from '../router';

// 设置默认请求头
axios.defaults.headers.common['Content-Type'] = 'application/json';
axios.defaults.timeout = 15000;

// http request 拦截器
axios.interceptors.request.use(
  config => {
    if (store.state.userInfo.token) {  // 判断是否存在token，如果存在的话，则每个http header都加上token
      config.headers["Authorization"] = `JWT ${store.state.userInfo.token}`;
      config.headers["x-token"] = `${store.state.userInfo.token}`;
    }
    return config;
  },
  err => {
    return Promise.reject(err);
  });


// http response 拦截器
axios.interceptors.response.use(
  response => {
    return response;
  },
  error => {
    let res = error.response;
    if (res) {
      switch (res.status) {
        case 401:
          // 返回 401 清除token信息并跳转到登录页面
          console.log('未登录');
          store.commit(types.LOGOUT);
          router.replace({
            path: '/login',
            query: {redirect: router.currentRoute.fullPath}
          });
          break;
        case 403:
          console.log('您没有该操作权限');
          break;
        case 500:
          console.log('服务器错误');
          break;
        default:
          console.log(`未知错误: ${res.status}`);
      }
    } else {
      console.log('网络错误，请检查您的网络连接');
    }
    return Promise.reject(error);
  });

export default axios;

