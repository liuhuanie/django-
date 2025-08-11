from django.contrib import admin
from .models import Order, OrderItem, Cart


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ['orderNo', 'user', 'totalAmount', 'status', 'receiver', 'createTime']
    list_filter = ['status', 'createTime']
    search_fields = ['orderNo', 'user__username', 'receiver']
    readonly_fields = ['orderNo', 'createTime']


@admin.register(OrderItem)
class OrderItemAdmin(admin.ModelAdmin):
    list_display = ['order', 'book', 'quantity', 'price', 'subtotal']
    list_filter = ['order__status']


@admin.register(Cart)
class CartAdmin(admin.ModelAdmin):
    list_display = ['user', 'book', 'quantity', 'addTime']
    list_filter = ['addTime']
    search_fields = ['user__username', 'book__bookName'] 