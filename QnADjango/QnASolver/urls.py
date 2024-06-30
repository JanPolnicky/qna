from django.urls import path
from .views import QuestionList, QuestionDetail, AnswerList, AnswerDetail, TopicList, TopicDetail

urlpatterns = [
    path('questions/', QuestionList.as_view(), name='question-list'),
    path('questions/<int:pk>/', QuestionDetail.as_view(), name='question-detail'),
    path('answers/', AnswerList.as_view(), name='answer-list'),
    path('answers/<int:pk>/', AnswerDetail.as_view(), name='answer-detail'),
    path('topics/', TopicList.as_view(), name='topic-list'),
    path('topics/<int:pk>/', TopicDetail.as_view(), name='topic-detail'),
]