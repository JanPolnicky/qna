from django.contrib import admin
from .models import Question, Answer, Topic


class AnswerInline(admin.TabularInline):
    model = Answer
    extra = 1  # how many rows to show

class QuestionAdmin(admin.ModelAdmin):
    inlines = [AnswerInline]
    list_display = ('name', 'status', 'display_answers', 'display_topics')
    list_filter = ('status', 'topics')

admin.site.register(Question, QuestionAdmin)
admin.site.register(Topic)