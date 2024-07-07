from rest_framework import generics
from .models import Question, Topic
from django.http import HttpResponse, JsonResponse
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from sentence_transformers import SentenceTransformer, util
import torch

from .serializers import QuestionSerializer, TopicSerializer
from .sentence_embeddings import model, question_embeddings, questions


def index(request):
    data = {"message": "Something else."}
    return JsonResponse(data)

def get_questions(request):
    questions = Question.objects.all()
    serializer = QuestionSerializer(questions, many=True)
    return JsonResponse(serializer.data, safe=False)

class QuestionList(generics.ListCreateAPIView):
    queryset = Question.objects.all()
    serializer_class = QuestionSerializer

class QuestionDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Question.objects.all()
    serializer_class = QuestionSerializer

class TopicList(generics.ListCreateAPIView):
    queryset = Topic.objects.all()
    serializer_class = TopicSerializer

class TopicDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Topic.objects.all()
    serializer_class = TopicSerializer

@csrf_exempt  # For development, remove in production
def find_similar_question_api(request):
    if request.method == 'POST':
        query = request.POST.get('query')
        if query:
            # Convert the query to a vector
            query_embedding = model.encode(query, convert_to_tensor=True)

            # Calculate the cosine similarity between the query vector and every question vector
            cos_scores = util.pytorch_cos_sim(query_embedding, question_embeddings)[0]

            # Find the top 5 questions with the highest cosine similarity scores
            top_results = torch.topk(cos_scores, k=5)

            # Get the IDs of the most similar questions
            most_similar_question_ids = [questions[int(index)][0] for index in top_results.indices]

            # Prepare the response data
            response_data = {
                'query': query,
                'most_similar_questions_ids': most_similar_question_ids
            }

            return JsonResponse(response_data, safe=False)
        else:
            return JsonResponse({'error': 'Missing query.'}, status=400)
    else:
        return JsonResponse({'error': 'Invalid method.'}, status=405)