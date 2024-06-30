from django import forms
from .models import Question, Answer

class QnAForm(forms.ModelForm):
    class Meta:
        model = Question
        fields = ['text']
        widgets = {
            'text': forms.Textarea(attrs={'rows': 4, 'cols': 15}),
        }

    answer_text = forms.CharField(widget=forms.Textarea(attrs={'rows': 4, 'cols': 15}))

    def save(self, commit=True):
        question = super().save(commit)
        Answer.objects.create(question=question, text=self.cleaned_data['answer_text'])
        return question