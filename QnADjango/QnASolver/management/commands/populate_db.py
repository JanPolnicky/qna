from django.core.management.base import BaseCommand
from QnASolver.models import Question
from faker import Faker

class Command(BaseCommand):
    help = 'Populates the database with fake questions and answers'

    def add_arguments(self, parser):
        parser.add_argument('records', type=int, help='Indicates the number of records to be created')

    def handle(self, *args, **kwargs):
        fake = Faker()
        records = kwargs['records']
        for _ in range(records):
            Question.objects.create(
                name=fake.sentence(),
                text=fake.sentence(),
                answer=fake.paragraph(),
                status='status_value',  # Replace with an appropriate status value
                # Add other fields as necessary
            )

        self.stdout.write(self.style.SUCCESS(f'Successfully created {records} records'))