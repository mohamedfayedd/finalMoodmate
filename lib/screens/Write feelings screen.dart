import 'package:flutter/material.dart';
import 'Feeling selection screen.dart';

class WriteFeelingsScreen extends StatefulWidget {
  @override
  _WriteFeelingsScreenState createState() => _WriteFeelingsScreenState();
}

class _WriteFeelingsScreenState extends State<WriteFeelingsScreen> {
  TextEditingController _controller = TextEditingController();
  String userFeeling = "Neutral"; // الحالة الافتراضية

  // قائمة الكلمات اللي بنبحث عنها في النص
  final List<String> keywords = [
    'sad', 'stressed', 'angry', 'lonely', 'depression', 'exhausted', 'anxious'
  ];

  void analyzeText(String text) {
    String detectedFeeling = "Neutral"; // افتراضيًا يكون محايد

    for (String word in keywords) {
      if (text.toLowerCase().contains(word)) {
        detectedFeeling = word; // لو لقى كلمة، يخزنها كحالة المستخدم
        break;
      }
    }

    setState(() {
      userFeeling = detectedFeeling;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Write what you feel',
          style: TextStyle(
            fontSize: 20,
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
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Container(
              width: 382,
              height: 194,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 6,
                maxLength: 500,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Write what you feel ....',
                  border: InputBorder.none,
                  counterText: "",
                ),
                onChanged: (text) {
                  analyzeText(text); // تحليل النص عند أي تغيير
                },
              ),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${_controller.text.length} / 500',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Detected Feeling: $userFeeling', // عرض الحالة الحالية
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            Spacer(),
            Container(
              width: 382,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFF9616FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeelingSelectionScreen(
                        userFeeling: userFeeling, // إرسال الحالة للصفحة الثانية
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
