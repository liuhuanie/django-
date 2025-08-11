# 配置支付宝支付的参数
from pathlib import Path
import os

# 沙箱环境的APPID
APPID = '9021000150648444'

# 设置存储密钥的文件路径

ALIPAY_KEY_PATH = os.path.join(Path(__file__).resolve().parent.parent, 'alipay')

# 应用的公钥
ALIPAY_PUBLIC_KEY = open(os.path.join(ALIPAY_KEY_PATH,"应用公钥RSA2048.txt"),
                         'r',encoding='utf-8').read()

print(ALIPAY_PUBLIC_KEY)

# 应用的私钥
ALIPAY_PRIVATE_KEY = open(os.path.join(ALIPAY_KEY_PATH,"应用私钥RSA2048.txt"),
                         'r',encoding='utf-8').read()


# 沙箱环境的支付宝网关地址
ALIPAY_GATEWAY_URL = 'https://openapi-sandbox.dl.alipaydev.com/gateway.do'