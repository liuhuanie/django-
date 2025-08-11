from apps.BookType.views import FrontAddView, ListAllView, FrontListView
from django.urls import re_path

# 正在部署的应用的名称
app_name = 'BookType'

urlpatterns = [
    re_path(r'^frontAdd$', FrontAddView.as_view(), name='frontAdd'),  # 前台图书类别添加
    re_path(r'^frontList$', FrontListView.as_view(), name='frontList'),  # 前台图书类别查询列表
    re_path(r'^listAll$', ListAllView.as_view(), name='listAll'),  # 获取所有图书类别
] 