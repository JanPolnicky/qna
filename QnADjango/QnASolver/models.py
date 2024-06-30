from django.db import models
from django.urls import reverse
from django.contrib.auth.models import User

class Topic(models.Model):
    name = models.CharField(max_length=200, unique=True, help_text='Insert topics which are related to this question.')

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('topic_detail', args=[str(self.id)])

    class Meta:
        ordering = ['name']

    def save(self, *args, **kwargs):
        self.name = self.name.lower()
        return super().save(*args, **kwargs)


class Question(models.Model):

    STATUS_CHOICES = [
        ('s', 'Solved'),
        ('u', 'Unsolved'),
    ]

    topics = models.ManyToManyField(Topic)
    name = models.CharField(max_length=200,default="")
    text = models.TextField()
    created_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, auto_created=True)
    created_at = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='u')

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('question_detail', args=[str(self.id)])

    class Meta:
        ordering = ['-created_at']

    def display_answers(self):
        return ", ".join([str(answer) for answer in self.answers.all()])
    display_answers.short_description = 'Answers'

    def display_topics(self):
        return ", ".join([str(topic) for topic in self.topics.all()])
    display_topics.short_description = 'Topics'

class Answer(models.Model):
    question = models.ForeignKey(Question, on_delete=models.SET_NULL, null=True, related_name='answers')
    text = models.TextField()

    def __str__(self):
        return self.text

    def get_absolute_url(self):
        return reverse('answer_detail', args=[str(self.id)])

    class Meta:
        ordering = ['id']

