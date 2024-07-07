from django.core.management.base import BaseCommand
from sentence_transformers import SentenceTransformer, util
import torch

from QnASolver.models import Question

class Command(BaseCommand):
    help = 'Runs the sentence embeddings script'

    def handle(self, *args, **options):
        # Load the sentence transformer model
        model = SentenceTransformer('all-MiniLM-L6-v2')

        # Load your data from the database
        questions = list(Question.objects.all().values_list('id', 'text'))
        answers = list(Question.objects.all().values_list('id', 'answer'))

        # Convert your questions to vectors
        question_texts = [text for id, text in questions]
        question_embeddings = model.encode(question_texts, convert_to_tensor=True)

        def find_most_similar_question(query):
            # Convert the query to a vector
            query_embedding = model.encode(query, convert_to_tensor=True)

            # Calculate the cosine similarity between the query vector and every question vector
            cos_scores = util.pytorch_cos_sim(query_embedding, question_embeddings)[0]

            # Find the question with the highest cosine similarity score
            top_results = torch.topk(cos_scores, k=1)
            most_similar_question_id, most_similar_question_text = questions[int(top_results.indices[0])]
            most_similar_answer_id, most_similar_answer_text = answers[int(top_results.indices[0])]

            print(f"Query: {query}")
            print(f"Most similar question ID: {most_similar_question_id}")
            print(f"Most similar question: {most_similar_question_text}")
            print(f"Answer ID: {most_similar_answer_id}")
            print(f"Answer: {most_similar_answer_text}")

        query = "This is qstn 9"
        find_most_similar_question(query)