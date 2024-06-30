import 'package:http/http.dart' as http;
import 'dart:convert';
import 'topic_model.dart';

class Topics {
  static final Topics _instance = Topics._internal();

  factory Topics() => _instance;

  Topics._internal() {
    loadTopics();
  }

  List<Topic> _topics = [];

  List<Topic> get topics => _topics;

  void addTopic(Topic topic) {
    _topics.add(topic);
  }

  void removeTopic(Topic topic) {
    _topics.remove(topic);
  }

  Future<void> loadTopics() async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/topics/'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      _topics = jsonList.map((json) => Topic.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load topics');
    }
  }
}