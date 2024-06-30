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
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Questions'),
            ),
            body: Column(
              children: [
                Text(questions.length.toString()),
                Expanded(
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(questions[index].id.toString()),
                        onDismissed: (direction) {
                          setState(() {
                            questions.removeQuestion(questions[index]);
                          });
                        },
                        child: ListTile(
                          title: Text(questions[index].name),
                          subtitle: Text(questions[index].text),
                          onTap: () {
                            // Navigate to the EditQuestionScreen
                            // You'll need to implement this screen and the navigation logic
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/questions/add');
              },
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }
}