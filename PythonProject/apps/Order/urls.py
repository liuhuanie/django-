from django.urls import re_path
from apps.Order.views import (
    CartView, AddToCartView, UpdateCartView, RemoveFromCartView,
    UpdateSessionCartView, RemoveFromSessionCartView, MergeSessionCartView,
    CheckoutView, CreateOrderView, OrderListView, OrderDetailView,
    PayOrderView, CancelOrderView, PayCallbackView, StorePayInfoView,
    CreateTestOrderView, PayTestView  # 新增测试订单视图和支付测试页面
)

app_name = 'Order'

urlpatterns = [
    re_path(r'^cart$', CartView.as_view(), name='cart'),  # 购物车
    re_path(r'^add-to-cart$', AddToCartView.as_view(), name='add_to_cart'),  # 添加到购物车
    re_path(r'^update-cart$', UpdateCartView.as_view(), name='update_cart'),  # 更新购物车
    re_path(r'^remove-from-cart$', RemoveFromCartView.as_view(), name='remove_from_cart'),  # 移除购物车
    re_path(r'^update-session-cart$', UpdateSessionCartView.as_view(), name='update_session_cart'),  # 更新session购物车
    re_path(r'^remove-from-session-cart$', RemoveFromSessionCartView.as_view(), name='remove_from_session_cart'),  # 移除session购物车
    re_path(r'^merge-session-cart$', MergeSessionCartView.as_view(), name='merge_session_cart'),  # 合并session购物车
    re_path(r'^checkout$', CheckoutView.as_view(), name='checkout'),  # 结算页面
    re_path(r'^create-order$', CreateOrderView.as_view(), name='create_order'),  # 创建订单
    re_path(r'^orders$', OrderListView.as_view(), name='order_list'),  # 订单列表
    re_path(r'^order/(?P<order_id>\d+)$', OrderDetailView.as_view(), name='order_detail'),  # 订单详情
    re_path(r'^pay-order$', PayOrderView.as_view(), name='pay_order'),  # 支付订单
    re_path(r'^pay-callback/$', PayCallbackView.as_view(), name='pay_callback'),  # 支付宝回调
    re_path(r'^store_pay_info/$', StorePayInfoView.as_view(), name='store_pay_info'),  # 支付宝回调
    re_path(r'^cancel-order$', CancelOrderView.as_view(), name='cancel_order'),  # 取消订单
    re_path(r'^create-test-order$', CreateTestOrderView.as_view(), name='create_test_order'),  # 创建测试订单
    re_path(r'^pay-test$', PayTestView.as_view(), name='pay_test'),  # 支付测试页面
]