import 'package:flutter/material.dart';
import 'listen_quran.dart'; // ✅ استيراد صفحة الاستماع للقرآن
import 'read_book_screen.dart'; // ✅ استيراد صفحة قراءة الكتب
import 'watch_video_screen.dart'; // ✅ استيراد صفحة مشاهدة الفيديوهات
import 'rate_progress_screen.dart'; // ✅ استيراد صفحة تقييم التقدم

class TreatmentSuggestionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Let’s improve your mood",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RateMoodScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  buildOption(context, "assets/images/quran.png", isQuran: true),
                  buildOption(context, "assets/images/book.png", isBook: true),
                  buildOption(context, "assets/images/videos.png", isVideo: true), // ✅ إضافة التنقل لصفحة الفيديوهات
                  buildOption(context, "assets/images/broadcast.png"),
                  buildOption(context, "assets/images/relaxation.png"),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 382,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  // Action for End Session button
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9616FF),
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "End Session",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 21),
          ],
        ),
      ),
    );
  }

  Widget buildOption(BuildContext context, String imagePath, {bool isQuran = false, bool isBook = false, bool isVideo = false}) {
    return GestureDetector(
      onTap: () {
        if (isQuran) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListenQuran()),
          );
        } else if (isBook) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReadBooksScreen()),
          );
        } else if (isVideo) { // ✅ إضافة شرط جديد للانتقال لصفحة الفيديوهات
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WatchVideoScreen(),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
