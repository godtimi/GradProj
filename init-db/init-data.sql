-- 使用用户数据库
USE yymall_user;

-- 插入管理员用户 (密码为admin123的MD5值)
INSERT INTO `user` (`mobile`, `password`, `nick_name`, `gender`, `role`, `add_time`, `update_time`)
VALUES ('13800138000', '0192023a7bbd73250516f069df18b500', 'admin', 'male', 2, NOW(), NOW());

-- 使用商品数据库
USE yymall_goods;

-- 插入示例商品分类
INSERT INTO `category` (`name`, `level`, `is_tab`, `add_time`, `update_time`)
VALUES 
('电子产品', 1, 1, NOW(), NOW()),
('服装', 1, 1, NOW(), NOW()),
('图书', 1, 1, NOW(), NOW());

-- 插入示例品牌
INSERT INTO `brands` (`name`, `logo`, `add_time`, `update_time`)
VALUES 
('Apple', '/static/brand/apple.png', NOW(), NOW()),
('Nike', '/static/brand/nike.png', NOW(), NOW()),
('人民文学出版社', '/static/brand/rmwx.png', NOW(), NOW());

-- 插入示例商品
INSERT INTO `goods` (`category_id`, `brand_id`, `goods_sn`, `name`, `market_price`, `shop_price`, `goods_brief`, `ship_free`, `is_new`, `is_hot`, `add_time`, `update_time`)
VALUES 
(1, 1, 'G000001', 'iPhone 15', 6999, 6799, '最新款iPhone', 1, 1, 1, NOW(), NOW()),
(2, 2, 'G000002', 'Nike运动鞋', 899, 799, '舒适耐穿', 1, 0, 1, NOW(), NOW()),
(3, 3, 'G000003', '三体全集', 199, 168, '刘慈欣科幻代表作', 1, 0, 1, NOW(), NOW());

-- 使用库存数据库
USE yymall_inventory;

-- 插入示例库存
INSERT INTO `inventory` (`goods`, `stocks`, `version`, `add_time`, `update_time`)
VALUES 
(1, 100, 0, NOW(), NOW()),
(2, 200, 0, NOW(), NOW()),
(3, 500, 0, NOW(), NOW()); 