import 'package:flutter/material.dart';
import 'package:qna_flutter/models/topics_model.dart';
import 'package:qna_flutter/screens/question_form_screen.dart';
import 'package:qna_flutter/screens/questions_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Topics topics = Topics();

  @override
  void initState() {
    super.initState();
    topics.loadTopics();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Questions'),
              Tab(text: 'Question Form'),
              Tab(text: 'Topics'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Replace these with the actual widgets for each tab
            Container(), // Questions tab
            QuestionForm(), // Question Form tab
            Container(), // Topics tab
          ],
        ),
      ),
    );
  }
}