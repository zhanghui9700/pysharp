#-*-coding=utf-*-

from django.conf.urls import patterns, include, url
from django.contrib import admin

from rest_framework import routers
from rest_framework.authtoken import views as auth_views

from rest_framework_swagger.views import get_swagger_view

from account import urls as account_urls


urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'xweb.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', include(admin.site.urls)),
)

schema_view = get_swagger_view(title='xWeb API', url="http://www.fx-dev.com:9900/")

urlpatterns += [
    # http://www.django-rest-framework.org/api-guide/authentication/
    url(r'^api/auth/token/$', auth_views.obtain_auth_token),
    url(r'^auth/', include('rest_framework.urls',
                        namespace='rest_framework')),

    url(r'^api/account/', include('account.urls')),

    # api documention
    url(r'^docs/$', schema_view)
]
