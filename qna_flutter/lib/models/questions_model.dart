import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'question_model.dart';

class Questions extends ChangeNotifier with ListMixin<Question>{
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

  Question getQuestionById(int id) {
    return _questions.firstWhere((question) => question.id == id);
  }

  @override
  Question operator [](int index) => _questions[index];

  @override
  void operator []=(int index, Question value) {
    _questions[index] = value;
  }

  @override
  int get length => _questions.length;

  @override
  set length(int newLength) {
    _questions.length = newLength;
  }

  Future<void> loadQuestions() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/questions/?format=json'));

  if (response.statusCode == 200) {
    if (response.body != null) {
      List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      _questions = jsonList.take(10).map((json) => Question.fromJson(json)).toList();
    } else {
      print('Response body is null');
    }
  } else {
    throw Exception('Failed to load questions');
  }
}

  Future<void> addQuestionToBackend(Question question) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/questions/'),
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

  @override
  String toString() {
    return 'Questions: ${_questions.map((question) => question.toString()).join(', ')}';
  }
}
