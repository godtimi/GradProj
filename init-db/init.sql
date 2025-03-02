-- 创建数据库
CREATE DATABASE IF NOT EXISTS yymall_user;
CREATE DATABASE IF NOT EXISTS yymall_goods;
CREATE DATABASE IF NOT EXISTS yymall_order;
CREATE DATABASE IF NOT EXISTS yymall_userop;
CREATE DATABASE IF NOT EXISTS yymall_inventory;

-- 使用yymall_user数据库
USE yymall_user;

-- 创建用户表
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(11) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nick_name` varchar(20) DEFAULT '',
  `birthday` datetime DEFAULT NULL,
  `gender` varchar(6) DEFAULT 'male',
  `role` int(11) DEFAULT 1,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile_unique` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 使用yymall_goods数据库
USE yymall_goods;

-- 创建商品分类表
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `parent_category_id` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 1,
  `is_tab` tinyint(1) DEFAULT 0,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 创建品牌表
CREATE TABLE IF NOT EXISTS `brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `logo` varchar(200) DEFAULT '',
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 创建商品表
CREATE TABLE IF NOT EXISTS `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `on_sale` tinyint(1) DEFAULT 1,
  `goods_sn` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `click_num` int(11) DEFAULT 0,
  `sold_num` int(11) DEFAULT 0,
  `fav_num` int(11) DEFAULT 0,
  `market_price` float DEFAULT 0,
  `shop_price` float DEFAULT 0,
  `goods_brief` varchar(200) DEFAULT '',
  `ship_free` tinyint(1) DEFAULT 1,
  `images` json DEFAULT NULL,
  `desc_images` json DEFAULT NULL,
  `goods_front_image` varchar(200) DEFAULT '',
  `is_new` tinyint(1) DEFAULT 0,
  `is_hot` tinyint(1) DEFAULT 0,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `goods_sn_unique` (`goods_sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 使用yymall_inventory数据库
USE yymall_inventory;

-- 创建库存表
CREATE TABLE IF NOT EXISTS `inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods` int(11) NOT NULL,
  `stocks` int(11) DEFAULT 0,
  `version` int(11) DEFAULT 0,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `goods_unique` (`goods`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 使用yymall_order数据库
USE yymall_order;

-- 创建订单表
CREATE TABLE IF NOT EXISTS `order_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `order_sn` varchar(30) NOT NULL,
  `pay_type` varchar(30) DEFAULT 'alipay',
  `status` varchar(30) DEFAULT 'pending',
  `trade_no` varchar(100) DEFAULT '',
  `order_mount` float DEFAULT 0,
  `pay_time` datetime DEFAULT NULL,
  `address` varchar(200) DEFAULT '',
  `signer_name` varchar(50) DEFAULT '',
  `signer_mobile` varchar(11) DEFAULT '',
  `post` varchar(20) DEFAULT '',
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_sn_unique` (`order_sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 创建订单商品表
CREATE TABLE IF NOT EXISTS `order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order` int(11) NOT NULL,
  `goods` int(11) NOT NULL,
  `goods_name` varchar(100) NOT NULL,
  `goods_image` varchar(200) DEFAULT '',
  `goods_price` float DEFAULT 0,
  `nums` int(11) DEFAULT 0,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 使用yymall_userop数据库
USE yymall_userop;

-- 创建用户收藏表
CREATE TABLE IF NOT EXISTS `user_fav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `goods` int(11) NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_goods_unique` (`user`, `goods`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 创建用户地址表
CREATE TABLE IF NOT EXISTS `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `province` varchar(20) NOT NULL,
  `city` varchar(20) NOT NULL,
  `district` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL,
  `signer_name` varchar(50) NOT NULL,
  `signer_mobile` varchar(11) NOT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 创建用户留言表
CREATE TABLE IF NOT EXISTS `leavingmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `message_type` int(11) DEFAULT 1,
  `subject` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `file` varchar(200) DEFAULT '',
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; 