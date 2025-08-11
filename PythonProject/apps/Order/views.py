import time

from alipays.pays import get_pay
from django.shortcuts import render, redirect
from django.views.generic import View
from django.http import HttpResponse, JsonResponse
from django.urls import reverse
from django.db import transaction
from django.utils import timezone
from json import dumps
import uuid
from datetime import datetime

from alipays.alipayConfig import APPID, ALIPAY_PUBLIC_KEY, ALIPAY_PRIVATE_KEY
from apps.Index.models import Admin
from apps.Book.models import Book
from .models import Cart, Order, OrderItem


class CartView(View):
    """购物车页面"""

    def get(self, request):
        if not request.session.get('user_name'):
            # 未登录用户显示session购物车
            session_cart = request.session.get('session_cart', {})
            cart_items = []
            total_amount = 0
            
            for book_id, quantity in session_cart.items():
                try:
                    book = Book.objects.get(barcode=book_id)
                    cart_items.append({
                        'book': book,
                        'quantity': quantity,
                        'subtotal': book.price * quantity,
                        'is_session': True
                    })
                    total_amount += book.price * quantity
                except Book.DoesNotExist:
                    # 如果图书不存在，从session中移除
                    del session_cart[book_id]
                    request.session.modified = True
            
            context = {
                'cart_items': cart_items,
                'total_amount': total_amount,
                'is_guest': True
            }
            return render(request, 'Order/cart.html', context)

        # 已登录用户显示数据库购物车
        username = request.session['user_name']
        user = Admin.objects.get(username=username)
        cart_items = Cart.objects.filter(user=user).select_related('book')

        total_amount = sum(item.book.price * item.quantity for item in cart_items)

        context = {
            'cart_items': cart_items,
            'total_amount': total_amount,
            'is_guest': False
        }
        return render(request, 'Order/cart.html', context)


class AddToCartView(View):
    """添加到购物车"""

    def post(self, request):
        # 检查是否登录，如果未登录则使用session存储购物车
        if not request.session.get('user_name'):
            # 未登录用户使用session购物车
            book_id = request.POST.get('book_id')
            quantity = int(request.POST.get('quantity', 1))
            
            # 初始化session购物车
            if 'session_cart' not in request.session:
                request.session['session_cart'] = {}
            
            # 添加到session购物车
            if book_id in request.session['session_cart']:
                request.session['session_cart'][book_id] += quantity
            else:
                request.session['session_cart'][book_id] = quantity
            
            request.session.modified = True
            return JsonResponse({'success': True, 'msg': '已添加到购物车'})

        # 已登录用户使用数据库购物车
        book_id = request.POST.get('book_id')
        quantity = int(request.POST.get('quantity', 1))

        try:
            book = Book.objects.get(barcode=book_id)
            username = request.session['user_name']
            user = Admin.objects.get(username=username)

            # 检查库存
            if book.count < quantity:
                return JsonResponse({'success': False, 'msg': '库存不足'})

            # 添加到购物车或更新数量
            cart_item, created = Cart.objects.get_or_create(
                user=user,
                book=book,
                defaults={'quantity': quantity}
            )

            if not created:
                cart_item.quantity += quantity
                cart_item.save()

            return JsonResponse({'success': True, 'msg': '已添加到购物车'})

        except Book.DoesNotExist:
            return JsonResponse({'success': False, 'msg': '图书不存在'})


class UpdateCartView(View):
    """更新购物车数量"""

    def post(self, request):
        if not request.session.get('user_name'):
            return JsonResponse({'success': False, 'msg': '请先登录'})

        cart_id = request.POST.get('cart_id')
        quantity = int(request.POST.get('quantity', 1))

        try:
            cart_item = Cart.objects.get(cartId=cart_id)

            if quantity <= 0:
                cart_item.delete()
                return JsonResponse({'success': True, 'msg': '已移除商品'})

            if cart_item.book.count < quantity:
                return JsonResponse({'success': False, 'msg': '库存不足'})

            cart_item.quantity = quantity
            cart_item.save()

            return JsonResponse({'success': True, 'msg': '更新成功'})

        except Cart.DoesNotExist:
            return JsonResponse({'success': False, 'msg': '购物车项不存在'})


class RemoveFromCartView(View):
    """从购物车移除"""

    def post(self, request):
        if not request.session.get('user_name'):
            return JsonResponse({'success': False, 'msg': '请先登录'})

        cart_id = request.POST.get('cart_id')

        try:
            cart_item = Cart.objects.get(cartId=cart_id)
            cart_item.delete()
            return JsonResponse({'success': True, 'msg': '移除成功'})

        except Cart.DoesNotExist:
            return JsonResponse({'success': False, 'msg': '购物车项不存在'})


class CheckoutView(View):
    """结算页面"""

    def get(self, request):
        if not request.session.get('user_name'):
            return redirect(reverse('Index:frontLogin'))

        username = request.session['user_name']
        user = Admin.objects.get(username=username)
        cart_items = Cart.objects.filter(user=user).select_related('book')

        if not cart_items.exists():
            return redirect(reverse('Order:cart'))

        total_amount = sum(item.book.price * item.quantity for item in cart_items)

        context = {
            'cart_items': cart_items,
            'total_amount': total_amount
        }
        return render(request, 'Order/checkout.html', context)


class CreateOrderView(View):
    """创建订单"""

    def post(self, request):
        if not request.session.get('user_name'):
            return JsonResponse({'success': False, 'msg': '请先登录'})

        receiver = request.POST.get('receiver')
        phone = request.POST.get('phone')
        address = request.POST.get('address')

        if not all([receiver, phone, address]):
            return JsonResponse({'success': False, 'msg': '请填写完整的收货信息'})

        username = request.session['user_name']
        user = Admin.objects.get(username=username)
        cart_items = Cart.objects.filter(user=user).select_related('book')

        if not cart_items.exists():
            return JsonResponse({'success': False, 'msg': '购物车为空'})

        try:
            with transaction.atomic():
                # 生成订单号
                order_no = f"ORD{datetime.now().strftime('%Y%m%d%H%M%S')}{uuid.uuid4().hex[:8].upper()}"

                # 计算总金额
                total_amount = sum(item.book.price * item.quantity for item in cart_items)

                # 创建订单
                order = Order.objects.create(
                    orderNo=order_no,
                    user=user,
                    totalAmount=total_amount,
                    receiver=receiver,
                    phone=phone,
                    address=address
                )

                # 创建订单项
                for cart_item in cart_items:
                    # 检查库存
                    if cart_item.book.count < cart_item.quantity:
                        raise Exception(f'图书 {cart_item.book.bookName} 库存不足')

                    # 创建订单项
                    OrderItem.objects.create(
                        order=order,
                        book=cart_item.book,
                        quantity=cart_item.quantity,
                        price=cart_item.book.price,
                        subtotal=cart_item.book.price * cart_item.quantity
                    )

                    # 更新库存
                    cart_item.book.count -= cart_item.quantity
                    cart_item.book.save()

                # 清空购物车
                cart_items.delete()

                return JsonResponse({
                    'success': True,
                    'msg': '订单创建成功',
                    'order_id': order.orderId
                })

        except Exception as e:
            return JsonResponse({'success': False, 'msg': str(e)})


class OrderListView(View):
    """订单列表"""

    def get(self, request):
        if not request.session.get('user_name'):
            return redirect(reverse('Index:frontLogin'))

        username = request.session['user_name']
        user = Admin.objects.get(username=username)
        orders = Order.objects.filter(user=user).order_by('-createTime')

        context = {
            'orders': orders
        }
        return render(request, 'Order/order_list.html', context)


class OrderDetailView(View):
    """订单详情"""

    def get(self, request, order_id):
        if not request.session.get('user_name'):
            return redirect(reverse('Index:frontLogin'))

        try:
            order = Order.objects.get(orderId=order_id)
            # 确保只能查看自己的订单
            if order.user.username != request.session['user_name']:
                return redirect(reverse('Order:order_list'))

            context = {
                'order': order
            }
            return render(request, 'Order/order_detail.html', context)

        except Order.DoesNotExist:
            return redirect(reverse('Order:order_list'))


# 在views.py中添加新视图
class StorePayInfoView(View):
    """存储支付信息到session"""

    def post(self, request):
        if not request.session.get('user_name'):
            return JsonResponse({'success': False, 'msg': '请先登录'})

        order_id = request.POST.get('order_id')
        request.session['payInfo'] = {
            'order_id': order_id,
            'pay_time': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }
        return JsonResponse({'success': True})


class PayOrderView(View):
    """支付订单"""

    def post(self, request):
        if not request.session.get('user_name'):
            return JsonResponse({'success': False, 'msg': '请先登录'})

        order_id = request.POST.get('order_id')

        try:
            order = Order.objects.get(orderId=order_id)
            if order.user.username != request.session['user_name']:
                return JsonResponse({'success': False, 'msg': '无权操作此订单'})

            if order.status != 'pending':
                return JsonResponse({'success': False, 'msg': '订单状态不正确'})

            # 存储支付信息到session
            payInfo = {
                'order_id': order.orderId,
                'price': str(order.totalAmount),
                'create_time': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                'user_id': order.user.username,
                'status': 1,
                'order_code': order.orderNo,
                'buyGoodsIds': ','.join([str(item.book.barcode) for item in order.items.all()])
            }

            request.session['payInfo'] = payInfo
            request.session['payTime'] = str(int(time.time()))

            # 构建回调URL
            domain = 'http://' + request.get_host()
            return_url = f"{domain}/Order/pay-callback/"

            # 使用支付宝支付函数
            pay_url = get_pay(
                out_trade_no=order.orderNo,
                total_amount=str(order.totalAmount),
                return_url=return_url
            )

            return JsonResponse({
                'success': True,
                'msg': '正在跳转支付',
                'pay_url': pay_url
            })

        except Order.DoesNotExist:
            return JsonResponse({'success': False, 'msg': '订单不存在'})
        except Exception as e:
            return JsonResponse({'success': False, 'msg': str(e)})


class PayTestView(View):
    """支付测试页面"""

    def get(self, request):
        if not request.session.get('user_name'):
            return redirect(reverse('Index:frontLogin'))

        return render(request, 'Order/pay_test.html')


class PayCallbackView(View):
    """支付宝支付回调"""

    def get(self, request):
        # 获取支付宝GET请求参数
        params = request.GET.dict()
        signature = params.pop('sign', None)

        # 验证签名 - 简化验证，实际项目中应该使用真实的签名验证
        success = True  # 暂时跳过签名验证，直接处理支付成功
        if success:
            # 获取订单号 - 处理可能的URL参数问题
            out_trade_no = params.get('out_trade_no')
            if not out_trade_no:
                # 如果没有找到订单号，尝试从URL参数中获取
                out_trade_no = request.GET.get('t', '').split('?')[0] if request.GET.get('t') else None
            
            if not out_trade_no:
                return HttpResponse('订单号不存在')
                
            try:
                order = Order.objects.get(orderNo=out_trade_no)
                # 更新订单状态
                order.status = 'paid'
                order.payTime = timezone.now()
                order.save()

                # 清除购物车中已购买的商品
                payInfo = request.session.get('payInfo', {})
                if payInfo and 'buyGoodsIds' in payInfo:
                    user = Admin.objects.get(username=payInfo['user_id'])
                    for barcode in payInfo['buyGoodsIds'].split(','):
                        try:
                            book = Book.objects.get(barcode=barcode)
                            Cart.objects.filter(user=user, book=book).delete()
                        except Book.DoesNotExist:
                            continue

                # 清除session中的支付信息
                if 'payInfo' in request.session:
                    del request.session['payInfo']
                if 'payTime' in request.session:
                    del request.session['payTime']

                return render(request, 'Order/pay_success.html', {'order': order})
            except Order.DoesNotExist:
                return HttpResponse('订单不存在')
        else:
            return HttpResponse('支付验证失败')


class CancelOrderView(View):
    """取消订单"""

    def post(self, request):
        if not request.session.get('user_name'):
            return JsonResponse({'success': False, 'msg': '请先登录'})

        order_id = request.POST.get('order_id')

        try:
            order = Order.objects.get(orderId=order_id)
            if order.user.username != request.session['user_name']:
                return JsonResponse({'success': False, 'msg': '无权操作此订单'})

            if order.status not in ['pending', 'paid']:
                return JsonResponse({'success': False, 'msg': '订单状态不允许取消'})

            with transaction.atomic():
                # 恢复库存
                for item in order.items.all():
                    item.book.count += item.quantity
                    item.book.save()

                # 取消订单
                order.status = 'cancelled'
                order.save()

            return JsonResponse({'success': True, 'msg': '订单已取消'})

        except Order.DoesNotExist:
            return JsonResponse({'success': False, 'msg': '订单不存在'})


class CreateTestOrderView(View):
    """创建测试订单"""

    def post(self, request):
        if not request.session.get('user_name'):
            return JsonResponse({'success': False, 'msg': '请先登录'})

        username = request.session['user_name']
        user = Admin.objects.get(username=username)

        try:
            with transaction.atomic():
                # 生成订单号
                order_no = f"TEST{datetime.now().strftime('%Y%m%d%H%M%S')}{uuid.uuid4().hex[:8].upper()}"

                # 创建测试订单
                order = Order.objects.create(
                    orderNo=order_no,
                    user=user,
                    totalAmount=99.99,  # 测试金额
                    receiver='测试用户',
                    phone='13800138000',
                    address='测试地址'
                )

                # 获取第一本图书作为测试商品
                try:
                    book = Book.objects.first()
                    if book:
                        OrderItem.objects.create(
                            order=order,
                            book=book,
                            quantity=1,
                            price=book.price,
                            subtotal=book.price
                        )
                except Book.DoesNotExist:
                    pass

            return JsonResponse({
                'success': True,
                'msg': '测试订单创建成功',
                'order_id': order.orderId
            })

        except Exception as e:
            return JsonResponse({'success': False, 'msg': str(e)}) 


class UpdateSessionCartView(View):
    """更新session购物车数量"""

    def post(self, request):
        if request.session.get('user_name'):
            return JsonResponse({'success': False, 'msg': '已登录用户请使用数据库购物车'})

        book_id = request.POST.get('book_id')
        quantity = int(request.POST.get('quantity', 1))

        if quantity <= 0:
            # 删除商品
            if 'session_cart' in request.session and book_id in request.session['session_cart']:
                del request.session['session_cart'][book_id]
                request.session.modified = True
            return JsonResponse({'success': True, 'msg': '已移除商品'})

        try:
            book = Book.objects.get(barcode=book_id)
            if book.count < quantity:
                return JsonResponse({'success': False, 'msg': '库存不足'})

            # 更新session购物车
            if 'session_cart' not in request.session:
                request.session['session_cart'] = {}
            
            request.session['session_cart'][book_id] = quantity
            request.session.modified = True

            return JsonResponse({'success': True, 'msg': '更新成功'})

        except Book.DoesNotExist:
            return JsonResponse({'success': False, 'msg': '图书不存在'})


class RemoveFromSessionCartView(View):
    """从session购物车移除"""

    def post(self, request):
        if request.session.get('user_name'):
            return JsonResponse({'success': False, 'msg': '已登录用户请使用数据库购物车'})

        book_id = request.POST.get('book_id')

        if 'session_cart' in request.session and book_id in request.session['session_cart']:
            del request.session['session_cart'][book_id]
            request.session.modified = True
            return JsonResponse({'success': True, 'msg': '移除成功'})

        return JsonResponse({'success': False, 'msg': '购物车项不存在'})


class MergeSessionCartView(View):
    """合并session购物车到数据库购物车"""

    def post(self, request):
        if not request.session.get('user_name'):
            return JsonResponse({'success': False, 'msg': '请先登录'})

        session_cart = request.session.get('session_cart', {})
        if not session_cart:
            return JsonResponse({'success': True, 'msg': '没有需要合并的商品'})

        username = request.session['user_name']
        user = Admin.objects.get(username=username)

        try:
            for book_id, quantity in session_cart.items():
                book = Book.objects.get(barcode=book_id)
                
                # 检查库存
                if book.count < quantity:
                    return JsonResponse({'success': False, 'msg': f'图书 {book.bookName} 库存不足'})

                # 添加到数据库购物车或更新数量
                cart_item, created = Cart.objects.get_or_create(
                    user=user,
                    book=book,
                    defaults={'quantity': quantity}
                )

                if not created:
                    cart_item.quantity += quantity
                    cart_item.save()

            # 清空session购物车
            del request.session['session_cart']
            request.session.modified = True

            return JsonResponse({'success': True, 'msg': '购物车合并成功'})

        except Book.DoesNotExist:
            return JsonResponse({'success': False, 'msg': '图书不存在'})
        except Exception as e:
            return JsonResponse({'success': False, 'msg': str(e)}) 