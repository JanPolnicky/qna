import 'package:flutter/material.dart';
import 'package:qna_flutter/models/question_model.dart';
import 'package:qna_flutter/models/questions_model.dart';
import 'package:qna_flutter/models/topics_model.dart';

class AddQuestionScreen extends StatefulWidget {

  AddQuestionScreen();

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _textController = TextEditingController();
  final _answers = <TextEditingController>[];
  final _topicsController = TextEditingController();
  final questions = Questions();
  final topics = Topics();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Text'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter text';
                }
                return null;
              },
            ),
            SizedBox(
              height: 200, // Nastavte výšku podle potřeby
              child: ListView.builder(
                itemCount: _answers.length,
                itemBuilder: (context, index) {
                  return TextFormField(
                    controller: _answers[index],
                    decoration: InputDecoration(labelText: 'Answer ${index + 1}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _answers.add(TextEditingController());
                });
              },
              child: Text('Add Answer'),
            ),
            TextField(
              controller: _topicsController,
              decoration: InputDecoration(labelText: 'Topics (comma separated)'),
              onChanged: (value) {
                final topics = value.split(',').map((t) => t.trim().toLowerCase()).toList();
                for (final topic in topics) {
                  if (topics.contains(topic)) {
                    // Zobrazte chybovou hlášku
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Topic "$topic" already exists')),
                    );
                  }
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, create a new question and add it to the questions model
                  questions.addQuestion(Question(
                    id: questions.length + 1,  // Generate a new id for the question
                    name: _nameController.text,
                    text: _textController.text,
                    createdAt: DateTime.now().toString(),
                    status: 'u',
                    createdBy: 1,
                    answers: _answers.map((controller) => controller.text).toList(),
                    topics: _topicsController.text.split(',').map((t) => t.trim().toLowerCase()).toList(),
                    // Add other fields as needed
                  ));
                  Navigator.pop(context);  // Go back to the previous screen
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}