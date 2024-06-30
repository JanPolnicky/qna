
class Question {
  final int id;
  final List<dynamic> answers;
  final List<dynamic> topics;
  final String name;
  final String text;
  final String createdAt;
  final String status;
  final int? createdBy;  // Make createdBy nullable

  Question({
    required this.id,
    required this.answers,
    required this.topics,
    required this.name,
    required this.text,
    required this.createdAt,
    required this.status,
    this.createdBy,  // createdBy can now be null
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      answers: json['answers'],
      topics: json['topics'],
      name: json['name'],
      text: json['text'],
      createdAt: json['created_at'],
      status: json['status'],
      createdBy: json['created_by'],  // No need for null check here
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'text': text,
      'created_at': createdAt,
      'status': status,
      'created_by': createdBy,
      'answers': answers.map((answer) => {'text': answer}).toList(),
      'topics': topics.map((topic) => {'name': topic}).toList(),
    };
  }
}