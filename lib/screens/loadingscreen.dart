import 'package:flutter/material.dart';
import 'dart:async';
import 'view_book.dart'; // تأكد من أن هذا هو اسم الملف الصحيح لشاشة عرض الكتاب

class LoadingScreen extends StatefulWidget {
  final dynamic book; // يمكنك تغيير النوع حسب هيكل بيانات الكتاب
  const LoadingScreen({Key? key, required this.book}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  void startLoading() {
    // زيادة progress كل 500 مللي ثانية بحيث يكون إجمالي مدة التحميل 5 ثوانٍ (10 خطوات)
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (progress >= 1.0) {
        timer.cancel();
        // بعد انتهاء التحميل، يتم الانتقال إلى شاشة عرض الكتاب (ViewBookScreen) وتمرير بيانات الكتاب
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ViewBookScreen(book: widget.book),
          ),
        );
      } else {
        setState(() {
          progress = (progress + 0.1) > 1.0 ? 1.0 : progress + 0.1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // هنا نستخدم SafeArea ونبني الواجهة بنفس نمط شاشة الكتب
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // شريط التطبيق (App Bar) بنمط شاشة الكتب
            _buildAppBar(),
            SizedBox(height: 24),
            // محتوى شاشة التحميل
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Loading.. ${(progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[300],
                        color: Color(0xFF9616FF),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            widget.book['title'] ?? 'Loading...',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 40),
        ],
      ),
    );
  }
}
