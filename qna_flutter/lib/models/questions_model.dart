import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'question_model.dart';

class Questions extends ChangeNotifier{
  static final Questions _instance = Questions._internal();

  factory Questions() => _instance;

  Questions._internal() {
    loadQuestions();
  }

  List<Question> _questions = [];

  List<Question> get questions => _questions;

  void addQuestion(Question question) {
    _questions.add(question);
    addQuestionToBackend(question).then((_) {
      loadQuestions();
    });
    notifyListeners();
  }

  void removeQuestion(Question question) {
    _questions.remove(question);
  }

  Question operator [](int index) => _questions[index];

  int get length => _questions.length;

  Future<void> loadQuestions() async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/questions/?format=json'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      print('jsonList: $jsonList');
      _questions = jsonList.map((json) => Question.fromJson(json)).toList();
      print(_questions.toList().toString());
    } else {
      throw Exception('Failed to load questions');
    }
  }

  Future<void> addQuestionToBackend(Question question) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/questions/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(question.toJson()), // Použití metody toJson()
    );

    if (response.statusCode == 201) {
      print('Question added successfully');
    } else {
      throw Exception('Failed to add question');
    }
  }
}
