from transformers import BertTokenizer, BertForSequenceClassification, Trainer, TrainingArguments
from sklearn.model_selection import train_test_split
import torch

from QnASolver.models import Question
from sklearn.metrics import accuracy_score, precision_recall_fscore_support

def compute_metrics(pred):
    labels = pred.label_ids
    preds = pred.predictions.argmax(-1)
    precision, recall, f1, _ = precision_recall_fscore_support(labels, preds, average='binary')
    acc = accuracy_score(labels, preds)
    return {
        'accuracy': acc,
        'f1': f1,
        'precision': precision,
        'recall': recall
    }

# Load the BERT tokenizer and model
tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
model = BertForSequenceClassification.from_pretrained('bert-base-uncased')

# Load your data from the database
questions = Question.objects.all().values_list('text', flat=True)
answers = Question.objects.all().values_list('answer', flat=True)

# Preprocess the data
inputs = tokenizer(questions, return_tensors='pt', truncation=True, padding=True)
labels = torch.tensor([0]*len(questions))  # You need to replace this with your actual labels

# Split the data into training and testing sets
train_inputs, test_inputs, train_labels, test_labels = train_test_split(inputs, labels, test_size=0.2)

# Define the training arguments
training_args = TrainingArguments(
    output_dir='./results',          # output directory
    num_train_epochs=3,              # total number of training epochs
    per_device_train_batch_size=16,  # batch size per device during training
    per_device_eval_batch_size=64,   # batch size for evaluation
    warmup_steps=500,                # number of warmup steps for learning rate scheduler
    weight_decay=0.01,               # strength of weight decay
    logging_dir='./logs',            # directory for storing logs
)

# Define the trainer
trainer = Trainer(
    model=model,                         # the instantiated 🤗 Transformers model to be trained
    args=training_args,                  # training arguments, defined above
    train_dataset=train_inputs,          # training dataset
    eval_dataset=test_inputs,            # evaluation dataset
    compute_metrics=compute_metrics,     # function that computes metrics
)

# Train the model
trainer.train()

if __name__ == "__main__":
    query = "What is the Pythagorean theorem?"
    inputs = tokenizer(query, return_tensors='pt')
    outputs = model(**inputs)
    print(outputs)
    predicted_label = torch.argmax(outputs.logits)
    print(predicted_label)
