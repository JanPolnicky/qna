import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../models/questions_model.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final questions = Questions();
  late Future<void> loadQuestionsFuture;

  @override
  void initState() {
    super.initState();
    loadQuestionsFuture = questions.loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadQuestionsFuture,
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Questions'),
            ),
            body: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  questions[index].isExpanded = !questions[index].isExpanded;
                });
              },
              children: questions.map<ExpansionPanel>((Question question) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(question.name),
                    );
                  },
                  body: ListTile(
                    title: Text(question.text),
                    subtitle: Text('Answer: ${question.answer}'),
                  ),
                  isExpanded: question.isExpanded,
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
