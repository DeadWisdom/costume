from django.conf.urls import include, url
from django.contrib import admin

urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),

    url(r'^cards/$', 'costume.views.cards', name='cards'),
    url(r'^cards/(\d+)/delete/$', 'costume.views.delete', name='delete'),
    
    url(r'^reset/$', 'costume.views.reset', name='reset'),

    url(r'^$', 'costume.views.home', name='home'),
]
