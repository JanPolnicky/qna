import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/question_model.dart';
import '../models/questions_model.dart';

class QuestionForm extends StatefulWidget {
  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final questions = Questions();
  List<dynamic>? mostSimilarQuestionsIds;
  List<Question> foundQuestions = [];

  @override
  void initState() {
    super.initState();
    questions.loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Form'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Enter your question'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final query = _questionController.text;
                    final response = await http.post(
                      Uri.parse(
                          'http://127.0.0.1:8000/api/find_similar_question/'),
                      body: {'query': query},
                    );

                    if (response.statusCode == 200) {
                      final data = jsonDecode(response.body);
                      mostSimilarQuestionsIds = data['most_similar_questions_ids'];
                      print(mostSimilarQuestionsIds!.length);
                      try {
                        for(var index in mostSimilarQuestionsIds!){
                          foundQuestions.add(questions.getQuestionById(index));
                          print(index);
                        }
                      }catch(e){
                        print(e);
                      }
                      print(foundQuestions);
                      setState(() {});
                    } else {
                      print('Error: ${response.statusCode}');
                    }
                  }
                },
                child: Text('Find Similar Question'),
              ),
              SizedBox(height: 20),
              if (mostSimilarQuestionsIds != null)
                ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      foundQuestions[index].isExpanded = !foundQuestions[index].isExpanded;
                    });
                  },
                  children: foundQuestions.map<ExpansionPanel>((
                      question) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(question.name),
                        );
                      },
                      body: ListTile(
                        title: Text(question.text),
                        subtitle: Text('Answer: ${question.answer ??
                            'No answer provided'}'),
                      ),
                      isExpanded: question.isExpanded,
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}