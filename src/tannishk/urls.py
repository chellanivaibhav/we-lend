from django.conf.urls import url
from . import views 
urlpatterns = [
	url(r'^users/$', views.user_list, name='post_list'),
	url(r'^users/(?P<wallet_number>[ A-Za-z0-9_@./#&+-]*)/$', views.user_detail,name = 'user_detail'),
	url(r'^community/$', views.community_create, name='community_create'),
	url(r'^community/add/(?P<id>[0-9]+)/(?P<wallet_number>[ A-Za-z0-9_@./#&+-]*)/$',views.community_add,name='community_add'),
	url(r'^community/(?P<id>[0-9]+)',views.community_id,name='community_id'),
#	url(r'^community/$', views.user_list, name='post_list'),

]