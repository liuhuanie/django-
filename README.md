# 图书售卖平台（Django项目）

## 项目简介
本项目是基于Django框架开发的图书售卖平台，支持图书浏览、分类、购物车、订单管理、支付等功能，适合学习、毕业设计和二次开发。

## 主要技术栈
- Python 3.x
- Django 2.2.5
- MySQL 8.x
- jQuery + Bootstrap + EasyUI（前端）
- 富文本编辑（tinymce）

---

## 数据库结构与字段说明
数据库名：`db_book`

### 1. t_admin（管理员/用户表）
| 字段名    | 类型         | 说明           |
|-----------|--------------|----------------|
| username  | varchar(20)  | 用户名，主键   |
| password  | varchar(32)  | 登录密码       |
| role      | int          | 身份（1管理员，0普通用户）|



### 2. t_booktype（图书类别表）
| 字段名        | 类型         | 说明           |
|---------------|--------------|----------------|
| bookTypeId    | int, PK, AI  | 类别ID         |
| bookTypeName  | varchar(40)  | 类别名称       |
| days          | int          | 可借阅天数     |

### 3. t_book（图书信息表）
| 字段名        | 类型         | 说明           |
|---------------|--------------|----------------|
| barcode       | varchar(20)  | 图书条形码，主键|
| bookName      | varchar(20)  | 图书名称       |
| bookTypeObj   | int, FK      | 图书类别ID     |
| price         | decimal(10,2)| 图书价格       |
| count         | int          | 图书库存       |
| publishDate   | varchar(20)  | 出版日期       |
| publish       | varchar(20)  | 出版社         |
| bookPhoto     | varchar(80)  | 图书图片路径   |
| bookDesc      | longtext     | 图书简介（富文本）|
| bookFile      | varchar(100) | 图书文件路径   |

### 4. t_cart（购物车表）
| 字段名    | 类型         | 说明           |
|-----------|--------------|----------------|
| cartId    | int, PK, AI  | 购物车ID       |
| user      | varchar(20)  | 用户名，外键   |
| book      | varchar(20)  | 图书条形码，外键|
| quantity  | int          | 数量           |
| addTime   | datetime     | 添加时间       |

### 5. t_order（订单表）
| 字段名        | 类型         | 说明           |
|---------------|--------------|----------------|
| orderId       | int, PK, AI  | 订单ID         |
| orderNo       | varchar(50)  | 订单号         |
| user          | varchar(20)  | 用户名，外键   |
| totalAmount   | decimal(10,2)| 订单总金额     |
| status        | varchar(20)  | 订单状态（pending, paid, shipped, completed, cancelled）|
| address       | longtext     | 收货地址       |
| phone         | varchar(20)  | 联系电话       |
| receiver      | varchar(50)  | 收货人         |
| createTime    | datetime     | 创建时间       |
| payTime       | datetime     | 支付时间       |
| shipTime      | datetime     | 发货时间       |
| completeTime  | datetime     | 完成时间       |

### 6. t_orderitem（订单明细表）
| 字段名    | 类型         | 说明           |
|-----------|--------------|----------------|
| itemId    | int, PK, AI  | 订单项ID       |
| order     | int, FK      | 订单ID         |
| book      | varchar(20)  | 图书条形码，外键|
| quantity  | int          | 购买数量       |
| price     | decimal(10,2)| 购买时价格     |
| subtotal  | decimal(10,2)| 小计           |

---

## 主要模块与接口说明

### 1. apps/Index（首页与用户管理）
- `IndexView`：网站首页展示。
- `FrontLoginView`：前台用户登录，支持session购物车合并。
- `FrontLoginOutView`：前台用户退出。
- `RegisterView`：用户注册，校验用户名、密码长度、唯一性。
- `LoginView`：后台管理员登录。
- `LoginOutView`：后台管理员退出。
- `ChangePasswordView`：管理员修改密码。
- `MainView`：后台主界面。

### 2. apps/BookType（图书类别管理）
- `FrontAddView`：前台添加图书类别（预留）。
- `ListAllView`：获取所有图书类别，返回JSON。
- `FrontListView`：分页查询图书类别，模板渲染。

### 3. apps/Book（图书信息管理）
- `FrontAddView`：前台添加图书，支持图片、文件上传。
- `FrontModifyView`：前台修改图书信息。
- `FrontListView`：前台图书查询与分页。
- `FrontShowView`：前台图书详情展示。
- `UpdateView`：Ajax方式更新图书信息。
- `AddView`：后台添加图书。
- `BackModifyView`：后台修改图书。
- `ListView`：后台图书列表，支持分页、条件查询。
- `DeletesView`：批量删除图书。
- `OutToExcelView`：导出图书信息为Excel。

### 4. apps/Order（购物车与订单管理）
- `CartView`：购物车页面，支持游客session购物车与登录用户数据库购物车。
- `AddToCartView`：添加商品到购物车（支持游客与登录用户）。
- `UpdateCartView`：更新购物车商品数量。
- `RemoveFromCartView`：移除购物车商品。
- `CheckoutView`：结算页面。
- `CreateOrderView`：创建订单，校验库存、生成订单号、扣减库存、清空购物车。
- `OrderListView`：订单列表。
- `OrderDetailView`：订单详情。
- `StorePayInfoView`：存储支付信息到session。
- `PayOrderView`：发起支付，生成支付宝支付链接。
- `PayCallbackView`：支付宝支付回调，更新订单状态、清理购物车。
- `CancelOrderView`：取消订单，恢复库存。
- `CreateTestOrderView`：创建测试订单。
- `UpdateSessionCartView`：更新游客session购物车数量。
- `RemoveFromSessionCartView`：移除session购物车商品。
- `MergeSessionCartView`：登录后合并session购物车到数据库。

---

## 典型业务流程说明

### 1. 用户注册与登录
- 用户可通过前台注册页面注册新账号，注册时校验用户名唯一性和密码长度。
- 登录支持前台（普通用户）和后台（管理员），登录成功后可进行购物、下单等操作。

### 2. 图书浏览与检索
- 支持按类别、名称、条形码、出版日期等条件查询图书。
- 图书详情页展示图书图片、简介、下载文件等。

### 3. 购物车管理
- 未登录用户使用session购物车，数据保存在浏览器会话。
- 登录用户购物车数据存储在数据库表`t_cart`。
- 支持添加、修改、删除购物车商品，登录后可合并session购物车。

### 4. 下单与支付
- 结算时校验购物车商品库存，生成订单和订单明细，扣减库存。
- 支持支付宝支付（需配置alipay相关参数），支付成功后回调更新订单状态。
- 支持订单取消，自动恢复库存。

### 5. 订单管理
- 用户可查看自己的订单列表和订单详情。
- 订单状态包括：待支付（pending）、已支付（paid）、已发货（shipped）、已完成（completed）、已取消（cancelled）。

---

## 启动与开发说明
1. 安装依赖：
   ```bash
   pip install -r requirements.txt
   ```
   （如无requirements.txt，请手动安装Django、pymysql、tinymce等依赖）
2. 配置数据库（MySQL），导入`mysql数据库/db_book.sql`文件。
3. 修改`PythonProject/settings.py`中的数据库连接信息（如有需要）。
4. 启动Django服务：
   ```bash
   python manage.py runserver
   ```
5. 访问：http://127.0.0.1:8000/

---

## 其他说明与注意事项
- 管理员初始账号见`t_admin`表（如root/root）。
- 支持富文本编辑（tinymce），图片/文件上传。
- 支持游客购物车，登录后可同步。
- 支付宝支付需配置相关公私钥和appid。
- 静态资源、模板、媒体文件目录结构清晰，便于扩展。
- 代码注释详细，便于二次开发。

---
如需二次开发或遇到问题，欢迎联系作者或查阅源码注释。 
