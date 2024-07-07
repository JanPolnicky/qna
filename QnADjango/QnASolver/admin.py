from django.contrib import admin
from .models import Question, Topic

class QuestionAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'status', 'display_topics')
    list_filter = ('status', 'topics')

admin.site.register(Question, QuestionAdmin)
admin.site.register(Topic)