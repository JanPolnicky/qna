class Topic {
  final int id;
  final String name;

  Topic({required this.id, required this.name});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      name: json['name'],
    );
  }
}