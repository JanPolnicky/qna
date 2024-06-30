import 'package:http/http.dart' as http;
import 'dart:convert';
import 'answer_model.dart';

class Answers {

  static final Answers _instance = Answers._internal();

  factory Answers() => _instance;

  Answers._internal() {
    loadAnswers();
  }

  List<Answer> _answers = [];

  List<Answer> get answers => _answers;

  void addAnswer(Answer answer) {
    _answers.add(answer);
  }

  void removeAnswer(Answer answer) {
    _answers.remove(answer);
  }

  Future<void> loadAnswers() async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/answers/'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      _answers = jsonList.map((json) => Answer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load answers');
    }
  }
}