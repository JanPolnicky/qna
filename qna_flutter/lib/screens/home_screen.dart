import 'package:flutter/material.dart';
import 'package:qna_flutter/models/topics_model.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Questions'),
              onTap: () {
                Navigator.pushNamed(context, '/questions');
              },
            ),
            ListTile(
              title: Text('Answers'),
              onTap: () {
                Navigator.pushNamed(context, '/answers');
              },
            ),
            ListTile(
              title: Text('Topics'),
              onTap: () {
                Navigator.pushNamed(context, '/topics');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: topics.topics.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(topics.topics[index].name),
            onTap: () {
              // Navigate to the TopicDetailScreen
              // You'll need to implement this screen and the navigation logic
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to a new screen to add a question
          // You'll need to implement this screen and the navigation logic
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}