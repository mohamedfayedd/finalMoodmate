import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<int> selectedAnswers = [-1, -1, -1, -1]; // Update with initial values for 4 questions

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'How would you describe your mood today?',
      'options': ['Happy', 'Sad', 'Anxious', 'Neutral', 'Excited'],
    },
    {
      'question': 'Have you been feeling more positive or negative lately?',
      'options': ['Very Positive', 'Somewhat Positive', 'Neutral', 'Somewhat Negative', 'Very Negative'],
    },
    {
      'question': 'What is your preferred activity to relax?',
      'options': ['Reading', 'Walking', 'Listening to Music', 'Watching TV', 'Exercising'],
    },
    {
      'question': 'How often do you practice mindfulness?',
      'options': ['Daily', 'Weekly', 'Rarely', 'Never', 'Occasionally'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SizedBox.shrink(), // Empty title for the AppBar
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Fixed container for the section header
          Container(
            width: double.infinity,
            height: 58,
            padding: EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Color(0xFF9616FF).withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0), // Adjusted to move text further down
              child: Center(
                child: Text(
                  'Mood-Related Questions',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // Expanded widget to allow scrolling of questions below the header
          Expanded(
            child: SingleChildScrollView( // Scrollable content for the questions
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(questions.length, (index) {
                  return buildQuestion(
                    questions[index]['question'],
                    questions[index]['options'],
                    selectedAnswers[index],
                        (selectedIndex) {
                      setState(() {
                        selectedAnswers[index] = selectedIndex;
                      });
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuestion(String question, List<String> options, int selectedIndex, Function(int) onSelect) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Column(
            children: List.generate(options.length, (index) {
              return GestureDetector(
                onTap: () => onSelect(index),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Color(0xFF9616FF).withOpacity(0.2)
                        : Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16)),
                  ),
                  child: Text(
                    options[index],
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
