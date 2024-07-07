class Question {
  final int id;
  final String answer;
  final List<dynamic>? topics;
  final String name;
  final String text;
  final String createdAt;
  final String status;
  final int? createdBy;
  bool isExpanded = false;

  Question({
    required this.id,
    required this.answer,
    this.topics,
    required this.name,
    required this.text,
    required this.createdAt,
    required this.status,
    this.createdBy,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
  return Question(
    id: json['id'],
    answer: json['answer'] ?? '',  // Use null-coalescing operator
    topics: json['topics'] as List<dynamic>?,
    name: json['name'] ?? '',  // Use null-coalescing operator
    text: json['text'] ?? '',  // Use null-coalescing operator
    createdAt: json['created_at'] ?? '',  // Use null-coalescing operator
    status: json['status'] ?? '',  // Use null-coalescing operator
    createdBy: json['created_by'],
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answer': answer,
      'topics': topics?.map((topic) => {'name': topic}).toList(),
      'name': name,
      'text': text,
      'created_at': createdAt,
      'status': status,
      'created_by': createdBy,
    };
  }

  @override
  String toString() {
    return 'Question{id: $id, name: $name, text: $text, answer: $answer, isExpanded: $isExpanded}';
  }
}