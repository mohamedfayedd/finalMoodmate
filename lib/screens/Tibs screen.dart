import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Tips and Guidance',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Here are some tips to manage anxiety:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              ...[  // قائمة النصائح
                'Deep breathing can help calm your mind.',
                'Progressive muscle relaxation helps reduce tension.',
                'Listening to calming music can soothe your mind.',
                'Mindfulness and meditation keep you grounded.',
                'Journaling helps process anxious thoughts.',
                'Physical activity can help reduce anxiety.',
                'Reduce caffeine and sugar intake.',
                'Positive affirmations can help shift mindset.',
              ].map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  '- $tip',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
