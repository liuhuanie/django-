from django.db import models
from apps.Index.models import Admin
from apps.Book.models import Book


class Order(models.Model):
    orderId = models.AutoField(primary_key=True, verbose_name='订单ID')
    orderNo = models.CharField(max_length=50, unique=True, verbose_name='订单号')
    user = models.ForeignKey(Admin, on_delete=models.CASCADE, verbose_name='用户', db_column='user')
    totalAmount = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='订单总金额')
    status = models.CharField(max_length=20, default='pending', verbose_name='订单状态')  # pending, paid, shipped, completed, cancelled
    address = models.TextField(verbose_name='收货地址')
    phone = models.CharField(max_length=20, verbose_name='联系电话')
    receiver = models.CharField(max_length=50, verbose_name='收货人')
    createTime = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    payTime = models.DateTimeField(null=True, blank=True, verbose_name='支付时间')
    shipTime = models.DateTimeField(null=True, blank=True, verbose_name='发货时间')
    completeTime = models.DateTimeField(null=True, blank=True, verbose_name='完成时间')

    class Meta:
        db_table = 't_Order'
        verbose_name = '订单'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.orderNo


class OrderItem(models.Model):
    itemId = models.AutoField(primary_key=True, verbose_name='订单项ID')
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='items', verbose_name='订单', db_column='order')
    book = models.ForeignKey(Book, on_delete=models.CASCADE, verbose_name='图书', db_column='book')
    quantity = models.IntegerField(verbose_name='购买数量')
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='购买时价格')
    subtotal = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='小计')

    class Meta:
        db_table = 't_OrderItem'
        verbose_name = '订单项'
        verbose_name_plural = verbose_name

    def __str__(self):
        return f"{self.order.orderNo} - {self.book.bookName}"


class Cart(models.Model):
    cartId = models.AutoField(primary_key=True, verbose_name='购物车ID')
    user = models.ForeignKey(Admin, on_delete=models.CASCADE, verbose_name='用户', db_column='user')
    book = models.ForeignKey(Book, on_delete=models.CASCADE, verbose_name='图书', db_column='book')
    quantity = models.IntegerField(default=1, verbose_name='数量')
    addTime = models.DateTimeField(auto_now_add=True, verbose_name='添加时间')

    class Meta:
        db_table = 't_Cart'
        verbose_name = '购物车'
        verbose_name_plural = verbose_name
        unique_together = ['user', 'book']  # 同一用户同一图书只能有一条记录

    def __str__(self):
        return f"{self.user.username} - {self.book.bookName}" 