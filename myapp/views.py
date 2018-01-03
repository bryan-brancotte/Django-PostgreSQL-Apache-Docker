from django.urls import reverse_lazy
from django.utils.translation import ugettext
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView, DeleteView, UpdateView

from myapp.models import Author


class AuthorCreate(CreateView):
    model = Author
    fields = ['name']


class AuthorUpdate(UpdateView):
    model = Author
    fields = ['name']
    template_name_suffix = '_update_form'


class AuthorDelete(DeleteView):
    model = Author
    success_url = reverse_lazy('myapp:author-list')
    template_name = "myapp/generic_confirm_delete.html"

    def get_context_data(self, **kwargs):
        context = super(AuthorDelete, self).get_context_data(**kwargs)
        context['kind'] = ugettext('Author')
        return context


class AuthorDetailView(DetailView):
    model = Author

    # def get_context_data(self, **kwargs):
    #     context = super(AuthorDetailView, self).get_context_data(**kwargs)
    #     context['now'] = timezone.now()
    #     return context


class AuthorListView(ListView):
    model = Author
