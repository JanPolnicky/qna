from django.urls import path
from .views import QuestionList, QuestionDetail, TopicList, TopicDetail, find_similar_question_api

urlpatterns = [
    path('questions/', QuestionList.as_view(), name='question-list'),
    path('questions/<int:pk>/', QuestionDetail.as_view(), name='question-detail'),
    path('topics/', TopicList.as_view(), name='topic-list'),
    path('topics/<int:pk>/', TopicDetail.as_view(), name='topic-detail'),
    path('find_similar_question/', find_similar_question_api, name='find_similar_question_api'),
]