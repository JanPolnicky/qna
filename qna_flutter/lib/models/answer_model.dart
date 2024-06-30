class Answer {
  final int id;
  final String text;
  final int questionId;

  Answer({required this.id, required this.text, required this.questionId});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      text: json['text'],
      questionId: json['question'],
    );
  }
}