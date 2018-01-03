from myapp.views import AuthorCreate, AuthorUpdate, AuthorDelete, AuthorListView, AuthorDetailView
from django.conf.urls import url

app_name = 'myapp'
urlpatterns = [
    url(r'^author/$', AuthorListView.as_view(), name='author-list'),
    url(r'^author/create/$', AuthorCreate.as_view(), name='author-create'),
    url(r'^author/(?P<pk>[1-9]\d*)/$', AuthorDetailView.as_view(), name='author-detail'),
    url(r'^author/(?P<pk>[1-9]\d*)/update/$', AuthorUpdate.as_view(), name='author-update'),
    url(r'^author/(?P<pk>[1-9]\d*)/delete/$', AuthorDelete.as_view(), name='author-delete'),
]
