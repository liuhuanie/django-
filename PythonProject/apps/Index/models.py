from django.db import models


class Admin(models.Model):
    username = models.CharField(max_length=20, primary_key=True, verbose_name='用户名')
    password = models.CharField(max_length=32, verbose_name='登录密码')
    role = models.IntegerField(default=0, verbose_name='身份', help_text='1为管理员，0为普通用户')

    class Meta:
        db_table = 't_admin'
        verbose_name = '管理员'
        verbose_name_plural = verbose_name
