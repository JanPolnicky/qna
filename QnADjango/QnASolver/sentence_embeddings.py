from django.core.management.base import BaseCommand
from sentence_transformers import SentenceTransformer, util
import torch

from QnASolver.models import Question

model = SentenceTransformer('all-MiniLM-L6-v2')
# Load your data from the database
questions = list(Question.objects.all().values_list('id', 'text'))
answers = list(Question.objects.all().values_list('id', 'answer'))

# Convert your questions to vectors
question_texts = [text for id, text in questions]
question_embeddings = model.encode(question_texts, convert_to_tensor=True)

def find_most_similar_questions(query, k=5):
    # Convert the query to a vector
    query_embedding = model.encode(query, convert_to_tensor=True)

    # Calculate the cosine similarity between the query vector and every question vector
    cos_scores = util.pytorch_cos_sim(query_embedding, question_embeddings)[0]

    # Find the top k questions with the highest cosine similarity scores
    top_results = torch.topk(cos_scores, k=k)

    # Get the IDs and texts of the most similar questions
    most_similar_questions = [questions[int(index)] for index in top_results.indices]

    print(f"Query: {query}")
    for question_id, question_text in most_similar_questions:
        print(f"Similar question ID: {question_id}")
        print(f"Similar question: {question_text}")

query = "This is qstn 9"
find_most_similar_questions(query)
