/*
 Navicat Premium Dump SQL

 Source Server         : JavaEE
 Source Server Type    : MySQL
 Source Server Version : 80100 (8.1.0)
 Source Host           : localhost:3306
 Source Schema         : db_book

 Target Server Type    : MySQL
 Target Server Version : 80100 (8.1.0)
 File Encoding         : 65001

 Date: 20/07/2025 11:15:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;


DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add 管理员', 7, 'add_admin');
INSERT INTO `auth_permission` VALUES (26, 'Can change 管理员', 7, 'change_admin');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 管理员', 7, 'delete_admin');
INSERT INTO `auth_permission` VALUES (28, 'Can view 管理员', 7, 'view_admin');
INSERT INTO `auth_permission` VALUES (29, 'Can add 图书类别', 8, 'add_booktype');
INSERT INTO `auth_permission` VALUES (30, 'Can change 图书类别', 8, 'change_booktype');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 图书类别', 8, 'delete_booktype');
INSERT INTO `auth_permission` VALUES (32, 'Can view 图书类别', 8, 'view_booktype');
INSERT INTO `auth_permission` VALUES (33, 'Can add 图书信息', 9, 'add_book');
INSERT INTO `auth_permission` VALUES (34, 'Can change 图书信息', 9, 'change_book');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 图书信息', 9, 'delete_book');
INSERT INTO `auth_permission` VALUES (36, 'Can view 图书信息', 9, 'view_book');
INSERT INTO `auth_permission` VALUES (37, 'Can add 购物车', 10, 'add_cart');
INSERT INTO `auth_permission` VALUES (38, 'Can change 购物车', 10, 'change_cart');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 购物车', 10, 'delete_cart');
INSERT INTO `auth_permission` VALUES (40, 'Can view 购物车', 10, 'view_cart');
INSERT INTO `auth_permission` VALUES (41, 'Can add 订单', 11, 'add_order');
INSERT INTO `auth_permission` VALUES (42, 'Can change 订单', 11, 'change_order');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 订单', 11, 'delete_order');
INSERT INTO `auth_permission` VALUES (44, 'Can view 订单', 11, 'view_order');
INSERT INTO `auth_permission` VALUES (45, 'Can add 订单项', 12, 'add_orderitem');
INSERT INTO `auth_permission` VALUES (46, 'Can change 订单项', 12, 'change_orderitem');
INSERT INTO `auth_permission` VALUES (47, 'Can delete 订单项', 12, 'delete_orderitem');
INSERT INTO `auth_permission` VALUES (48, 'Can view 订单项', 12, 'view_orderitem');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id` ASC) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (9, 'Book', 'book');
INSERT INTO `django_content_type` VALUES (8, 'BookType', 'booktype');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (7, 'Index', 'admin');
INSERT INTO `django_content_type` VALUES (10, 'Order', 'cart');
INSERT INTO `django_content_type` VALUES (11, 'Order', 'order');
INSERT INTO `django_content_type` VALUES (12, 'Order', 'orderitem');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'BookType', '0001_initial', '2019-10-23 16:25:20.559031');
INSERT INTO `django_migrations` VALUES (2, 'Book', '0001_initial', '2019-10-23 16:25:20.633729');
INSERT INTO `django_migrations` VALUES (3, 'Book', '0002_auto_20190907_1447', '2019-10-23 16:25:20.790853');
INSERT INTO `django_migrations` VALUES (4, 'Book', '0003_auto_20190907_1450', '2019-10-23 16:25:20.869061');
INSERT INTO `django_migrations` VALUES (5, 'Book', '0004_auto_20190908_1625', '2019-10-23 16:25:20.940749');
INSERT INTO `django_migrations` VALUES (6, 'Index', '0001_initial', '2019-10-23 16:25:20.997901');
INSERT INTO `django_migrations` VALUES (7, 'contenttypes', '0001_initial', '2019-10-23 16:25:21.098168');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0001_initial', '2019-10-23 16:25:21.480184');
INSERT INTO `django_migrations` VALUES (9, 'admin', '0001_initial', '2019-10-23 16:25:22.161958');
INSERT INTO `django_migrations` VALUES (10, 'admin', '0002_logentry_remove_auto_add', '2019-10-23 16:25:22.317199');
INSERT INTO `django_migrations` VALUES (11, 'admin', '0003_logentry_add_action_flag_choices', '2019-10-23 16:25:22.333745');
INSERT INTO `django_migrations` VALUES (12, 'contenttypes', '0002_remove_content_type_name', '2019-10-23 16:25:22.466614');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0002_alter_permission_name_max_length', '2019-10-23 16:25:22.536740');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0003_alter_user_email_max_length', '2019-10-23 16:25:22.613384');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0004_alter_user_username_opts', '2019-10-23 16:25:22.657501');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0005_alter_user_last_login_null', '2019-10-23 16:25:22.726562');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0006_require_contenttypes_0002', '2019-10-23 16:25:22.738593');
INSERT INTO `django_migrations` VALUES (18, 'auth', '0007_alter_validators_add_error_messages', '2019-10-23 16:25:22.755136');
INSERT INTO `django_migrations` VALUES (19, 'auth', '0008_alter_user_username_max_length', '2019-10-23 16:25:22.839932');
INSERT INTO `django_migrations` VALUES (20, 'auth', '0009_alter_user_last_name_max_length', '2019-10-23 16:25:22.906408');
INSERT INTO `django_migrations` VALUES (21, 'auth', '0010_alter_group_name_max_length', '2019-10-23 16:25:22.984405');
INSERT INTO `django_migrations` VALUES (22, 'auth', '0011_update_proxy_permissions', '2019-10-23 16:25:23.012979');
INSERT INTO `django_migrations` VALUES (23, 'sessions', '0001_initial', '2019-10-23 16:25:23.067122');
INSERT INTO `django_migrations` VALUES (24, 'Order', '0001_initial', '2025-07-19 10:07:22.000000');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin`  (
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES ('liu', '303986');
INSERT INTO `t_admin` VALUES ('root', 'root');

-- ----------------------------
-- Table structure for t_book
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book`  (
  `barcode` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bookName` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `count` int NOT NULL,
  `publishDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `publish` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bookPhoto` varchar(80) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bookDesc` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bookFile` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bookTypeObj` int NOT NULL,
  PRIMARY KEY (`barcode`) USING BTREE,
  INDEX `t_Book_bookTypeObj_7d2d8a28_fk_t_BookType_bookTypeId`(`bookTypeObj` ASC) USING BTREE,
  CONSTRAINT `t_Book_bookTypeObj_7d2d8a28_fk_t_BookType_bookTypeId` FOREIGN KEY (`bookTypeObj`) REFERENCES `t_booktype` (`bookTypeId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_book
-- ----------------------------
INSERT INTO `t_book` VALUES ('TS001', 'php网站编程入门', 35.50, 5, '2019-10-09', '人民教育出版社', 'img/1.jpg', '<p>这是一个编程入门书籍</p>', 'file/php.txt', 1);
INSERT INTO `t_book` VALUES ('TS002', '中国近代史', 39.90, 9, '2019-10-01', '科技大学出版社', 'img/2.jpg', '<p><span style=\"font-family: tahoma, arial, 宋体, sans-serif; font-size: 36px;\">中国近代史（1840---1919）（第四版） +&nbsp; 中国近代史（1919&mdash;1949）&nbsp;&nbsp;</span></p>', 'file/jindaishi.txt', 2);
INSERT INTO `t_book` VALUES ('TS003', 'Python项目开发案例集锦', 45.50, 12, '2019-10-09', '吉林大学出版社', 'img/3.jpg', '<ul id=\"J_AttrUL\" style=\"margin: 0px; padding: 0px 20px 18px; list-style: none; zoom: 1; border-top: 1px solid #ffffff; color: #404040; font-family: tahoma, arial, 微软雅黑, sans-serif; font-size: 12px;\">\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"Python项目开发案例集锦\" data-spm-anchor-id=\"a220o.1000855.0.i0.3e5e6b66KmRlws\">产品名称：Python项目开发案例集锦</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;9787569244403\">ISBN编号:&nbsp;9787569244403</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;Python项目开发案例集锦\">书名:&nbsp;Python项目开发案例集锦</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;殷丽爽\">作者:&nbsp;殷丽爽</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;128.00元\">定价:&nbsp;45.50元</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;Python项目开发案例集锦\">书名:&nbsp;Python项目开发案例集锦</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;否\">是否是套装:&nbsp;否</li>\r\n<li style=\"margin: 10px 15px 0px 0px; padding: 0px; list-style: none; display: inline; float: left; width: 220px; height: 18px; overflow: hidden; line-height: 18px; vertical-align: top; white-space: nowrap; text-overflow: ellipsis; color: #666666;\" title=\"&nbsp;吉林大学出版社\">出版社名称:&nbsp;吉林大学出版社</li>\r\n</ul>', 'file/NoFile.jpg', 1);
INSERT INTO `t_book` VALUES ('TS004', '平凡的世界', 50.00, 50, '2015-07-23', '人民出版社', 'img/文学.png', '<p><span style=\"font-family: \'Microsoft YaHei\', Arial, \'Hiragino Sans GB\', \'sans-serif\'; font-size: 14.5524px;\">《平凡的世界》是路遥创作的一部长篇小说，全书共三部，分别于1986年、1988年和1991年出版。这部作品以中国北方一个普通的农村家庭为背景，通过描绘主人公孙少平及其家人、朋友的生活变迁，深刻描绘了农村青年的成长、爱情、理想和现实的矛盾，展现了普通人在社会转型期的挣扎与追求，以及我国改革开放初期农村社会的沧桑巨变。该书以其真实、细腻的笔触，生动地刻画了众多性格鲜明的人物形象。</span></p>', 'file/NoFile.jpg', 3);
INSERT INTO `t_book` VALUES ('TS005', '活着', 50.00, 50, '2015-07-08', '人民出版社', 'img/小说.jpg', '<p><span style=\"background-color: rgba(16, 110, 190, 0.18); color: #111111; font-family: Arial, Helvetica, sans-serif; font-size: 20px;\">该作讲述了在大时代背景下</span><span style=\"color: #111111; font-family: Arial, Helvetica, sans-serif; font-size: 20px;\">，随着内战、 三反五反 、大跃进、 文化大革命 等社会变革， 徐福贵 的人生和家庭不断经受着苦难，最后所有亲人都先后离他而去，仅剩下他和一头老牛相依为命的故事。 通过普通平实的故事情节，展现了生命的意义和存在的价值，揭示了命运的无奈、生活的不可捉摸等。 该部小说于1998年荣获意大利格林扎纳&middot;卡佛文学奖最高奖项。 2002年，获第三届世界华文冰心文学奖</span></p>', 'file/NoFile.jpg', 3);
INSERT INTO `t_book` VALUES ('TS006', '三体', 50.00, 50, '2025-07-07', '人民出版社', 'img/科技.jpg', '<p><span style=\"color: #333333; font-family: \'Helvetica Neue\', Helvetica, Arial, \'PingFang SC\', \'Hiragino Sans GB\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif; text-indent: 28px;\">作品讲述了地球人类文明和三体文明的信息交流、生死搏杀及两个文明在宇宙中的兴衰历程。《三体》的文本叙事在&ldquo;后人类&rdquo;的思考上有着重大突破，构建了科学与文学的互动范式，将道德内涵引入</span><span style=\"color: #333333; font-family: \'Helvetica Neue\', Helvetica, Arial, \'PingFang SC\', \'Hiragino Sans GB\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif; text-indent: 28px;\">对科技的辩证思考中，并以文学手段在文化语境中对科技进行大胆假设和重构，但科技核心只是一个叙事跳板，是完成现实超越的重要媒介，也是人类命运共同体书写的重要工具。《三体》最吸引人的地方在于通</span><span style=\"color: #333333; font-family: \'Helvetica Neue\', Helvetica, Arial, \'PingFang SC\', \'Hiragino Sans GB\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif; text-indent: 28px;\">过</span><span style=\"color: #333333; font-family: \'Helvetica Neue\', Helvetica, Arial, \'PingFang SC\', \'Hiragino Sans GB\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif; text-indent: 28px;\">对人类中心主义的</span><span style=\"color: #333333; font-family: \'Helvetica Neue\', Helvetica, Arial, \'PingFang SC\', \'Hiragino Sans GB\', \'Microsoft YaHei\', \'WenQuanYi Micro Hei\', sans-serif; text-indent: 28px;\">解构，继而完成对人与自然、动物之间的伦理反思与文学表达，最终指向去人类中心化的思想内核。</span></p>', 'file/NoFile.jpg', 4);
INSERT INTO `t_book` VALUES ('TS007', '白夜行', 50.00, 50, '2025-07-07', '人民出版社', 'img/悬疑.jpg', '<p><span style=\"color: #111111; font-family: Arial, Helvetica, sans-serif; font-size: 20px;\">《</span><span style=\"font-weight: bold; background-color: rgba(16, 110, 190, 0.18); color: #111111; font-family: Arial, Helvetica, sans-serif; font-size: 20px;\">白夜行</span><span style=\"color: #111111; font-family: Arial, Helvetica, sans-serif; font-size: 20px;\">》是日本作家东野圭吾创作的长篇推理小说，2013年由南海出版公司推出中文版。 小说以1973年大阪废弃建筑内的男尸案为起点，展开嫌疑人之女唐泽雪穗与被害者之子桐原亮司长达19年的命运交织。 作品通过泡沫经济时代背景下的人物群像，揭示社会变迁导致的人性异化，被《周刊文春》评为推理小说榜年度第1名</span></p>', 'file/科技.jpg', 5);
INSERT INTO `t_book` VALUES ('TS008', '格林童话', 50.00, 50, '2025-07-07', '人民出版社', 'img/童话.jpg', '<p><span style=\"color: #333333; font-family: \'PingFang SC\', \'Lantinghei SC\', \'Microsoft YaHei\', arial, 宋体, sans-serif, tahoma; font-size: 16px;\">《格林童话》是由德国语言学家雅可布&middot;格林和威廉&middot;格林兄弟收集、整理、加工完成的德国民间文学。《格林童话》里面约有200多个故事，大部分源自民间的口头传说，其中的《灰姑娘》、《白雪公主》、《小红帽》、《青蛙王子》等童话故事较为闻名</span></p>', 'file/科技.jpg', 6);

-- ----------------------------
-- Table structure for t_booktype
-- ----------------------------
DROP TABLE IF EXISTS `t_booktype`;
CREATE TABLE `t_booktype`  (
  `bookTypeId` int NOT NULL AUTO_INCREMENT,
  `bookTypeName` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `days` int NOT NULL,
  PRIMARY KEY (`bookTypeId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_booktype
-- ----------------------------
INSERT INTO `t_booktype` VALUES (1, '计算机类', 30);
INSERT INTO `t_booktype` VALUES (2, '历史类', 25);
INSERT INTO `t_booktype` VALUES (3, '文学类', 30);
INSERT INTO `t_booktype` VALUES (4, '科幻与奇幻类', 30);
INSERT INTO `t_booktype` VALUES (5, '推理类', 30);
INSERT INTO `t_booktype` VALUES (6, '儿童读物类', 30);

-- ----------------------------
-- Table structure for t_cart
-- ----------------------------
DROP TABLE IF EXISTS `t_cart`;
CREATE TABLE `t_cart`  (
  `cartId` int NOT NULL AUTO_INCREMENT,
  `user` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `book` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT 1,
  `addTime` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`cartId`) USING BTREE,
  UNIQUE INDEX `unique_user_book`(`user` ASC, `book` ASC) USING BTREE,
  INDEX `t_Cart_book_fk`(`book` ASC) USING BTREE,
  INDEX `t_Cart_user_fk`(`user` ASC) USING BTREE,
  CONSTRAINT `t_Cart_book_fk` FOREIGN KEY (`book`) REFERENCES `t_book` (`barcode`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `t_Cart_user_fk` FOREIGN KEY (`user`) REFERENCES `t_admin` (`username`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_cart
-- ----------------------------

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`  (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `orderNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `user` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `totalAmount` decimal(10, 2) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'pending',
  `address` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `receiver` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `createTime` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `payTime` datetime(6) NULL DEFAULT NULL,
  `shipTime` datetime(6) NULL DEFAULT NULL,
  `completeTime` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`orderId`) USING BTREE,
  UNIQUE INDEX `orderNo`(`orderNo` ASC) USING BTREE,
  INDEX `t_Order_user_fk`(`user` ASC) USING BTREE,
  CONSTRAINT `t_Order_user_fk` FOREIGN KEY (`user`) REFERENCES `t_admin` (`username`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES (1, 'ORD20250719103051673A3EF0', 'liu', 71.00, 'paid', 'qq ', '18381613172', '欢 42207511', '2025-07-19 02:30:51.735540', '2025-07-19 02:31:00.246714', NULL, NULL);
INSERT INTO `t_order` VALUES (2, 'ORD20250719103518BAFC32E3', 'liu', 312.90, 'paid', 'eqeweqweq', '18381613172', '欢 42207511', '2025-07-19 02:35:18.361856', '2025-07-20 00:32:06.680554', NULL, NULL);
INSERT INTO `t_order` VALUES (4, 'ORD20250720084745359CAA06', 'liu', 177.50, 'pending', 'eqeweqweq', '18381613172', '欢 42207511', '2025-07-20 00:47:45.954272', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for t_orderitem
-- ----------------------------
DROP TABLE IF EXISTS `t_orderitem`;
CREATE TABLE `t_orderitem`  (
  `itemId` int NOT NULL AUTO_INCREMENT,
  `order` int NOT NULL,
  `book` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `subtotal` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`itemId`) USING BTREE,
  INDEX `t_OrderItem_order_fk`(`order` ASC) USING BTREE,
  INDEX `t_OrderItem_book_fk`(`book` ASC) USING BTREE,
  CONSTRAINT `t_OrderItem_book_fk` FOREIGN KEY (`book`) REFERENCES `t_book` (`barcode`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `t_OrderItem_order_fk` FOREIGN KEY (`order`) REFERENCES `t_order` (`orderId`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_orderitem
-- ----------------------------
INSERT INTO `t_orderitem` VALUES (1, 1, 'TS001', 2, 35.50, 71.00);
INSERT INTO `t_orderitem` VALUES (2, 2, 'TS002', 1, 39.90, 39.90);
INSERT INTO `t_orderitem` VALUES (3, 2, 'TS003', 6, 45.50, 273.00);
INSERT INTO `t_orderitem` VALUES (4, 4, 'TS001', 5, 35.50, 177.50);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `userId` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `gender` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `birthDate` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `userPhoto` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `telephone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `address` varchar(80) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `regTime` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
