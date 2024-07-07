from django import forms
from .models import Question

class QnAForm(forms.ModelForm):
    class Meta:
        model = Question
        fields = ['text', 'answer']  # Add 'answer' to the fields
        widgets = {
            'text': forms.Textarea(attrs={'rows': 4, 'cols': 15}),
            'answer': forms.Textarea(attrs={'rows': 4, 'cols': 15}),  # Add this line
        }