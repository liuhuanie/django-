# 向支付宝发送支付请求
from alipay import AliPay
import time
from .alipayConfig import *

def get_pay(out_trade_no, total_amount, return_url,):
    '''
    向支付宝发送支付链接
    :param out_trade_no:支付订单号
    :param total_amount:支付总金额
    :param return_url: 支付成功后返回的地址
    :return: 支付后的链接地址
    '''

    # 1 创建支付宝的SDK对象
    alipay = AliPay(
        appid=APPID,
        app_notify_url=None,  # 异步通知的地址
        alipay_public_key_string=ALIPAY_PUBLIC_KEY,
        app_private_key_string=ALIPAY_PRIVATE_KEY,
        sign_type='RSA2',  # 签名方式
        debug=True  # 调试模式
    )


    # 2 生成订单的支付请求参数
    order_string = alipay.api_alipay_trade_page_pay(
        out_trade_no=out_trade_no,  # 订单编号
        total_amount=str(total_amount),  # 支付金额
        subject='书香阁',  #支付主题
        return_url=return_url + '?t' + out_trade_no,  # 支付成功后返回的地址
        notify_url=return_url + '?t' + out_trade_no,  # 支付成功后异步的回调地址
    )

    return ALIPAY_GATEWAY_URL + '?' + order_string

