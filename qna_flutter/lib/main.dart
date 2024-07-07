import 'package:flutter/material.dart';
import 'package:qna_flutter/screens/home_screen.dart';
import 'package:qna_flutter/screens/question_add_screen.dart';
import 'package:qna_flutter/screens/question_form_screen.dart';
import 'package:qna_flutter/screens/questions_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/questions': (context) => QuestionsScreen(),
        '/questions/add': (context) => AddQuestionScreen(),
        '/question_form': (context) => QuestionForm(),
        //'/answers': (context) => AnswersScreen(),
        //'/topics': (context) => TopicsScreen(),
      },
    );
  }
}