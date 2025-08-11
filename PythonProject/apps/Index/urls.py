from django.urls import re_path
from apps.Index.views import IndexView,FrontLoginView,FrontLoginOutView,LoginView,LoginOutView,MainView,ChangePasswordView,RegisterView

# 正在部署的应用的名称
app_name = 'Index'

urlpatterns = [
    re_path(r'^$', IndexView.as_view(), name='index'),  # 首页
    re_path(r'^frontLogin$', FrontLoginView.as_view(), name='frontLogin'),  # 前台登录
    re_path(r'^frontLoginout$', FrontLoginOutView.as_view(), name='frontLoginout'),  # 前台退出
    re_path(r'^register$', RegisterView.as_view(), name='register'),  # 用户注册
    re_path(r'^login$', LoginView.as_view(), name="login"),  # 后台登录
    re_path(r'^loginout$', LoginOutView.as_view(), name="loginout"),  # 后台退出
    re_path(r'^changePassword$', ChangePasswordView.as_view(), name='changePassword'),  # 管理员修改密码
    re_path(r'^main$', MainView.as_view(), name='main')
]
