import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Camera Screen .dart'; // تأكد من استيراد الشاشة الجديدة
import 'profile.dart'; // استيراد شاشة الملف الشخصي
import 'Question screen.dart'; // استيراد شاشة الأسئلة
import 'write feelings screen.dart'; // استيراد شاشة كتابة المشاعر

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // النافيجيشن بار
            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 0.5, color: Colors.black),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Mood Mate",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()), // الانتقال إلى صفحة الملف الشخصي
                      );
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15), // المسافة بين الحاويتين
            // باقي الصفحة
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 382,
                    height: 446.48,
                    child: Column(
                      children: [
                        // اللوجو
                        SvgPicture.asset(
                          "assets/images/logo.svg",
                          width: 201.63,
                          height: 104.48,
                          fit: BoxFit.contain,
                        ),
                        const Spacer(),
                        // الأزرار
                        Column(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CameraScreen()), // الانتقال إلى صفحة CameraScreen
                                );
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Color(0xFF6F3C99),
                              ), // أيقونة الكاميرا
                              label: const Text(
                                "Take a Picture",
                                style: TextStyle(color: Color(0xFF6F3C99)),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE5E0FF),
                                padding: const EdgeInsets.symmetric(vertical: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16), // الحواف متساوية
                                ),
                                minimumSize: const Size(double.infinity, 72),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => QuestionScreen()), // الانتقال إلى شاشة الأسئلة
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              ), // أيقونة القلم
                              label: const Text(
                                "Answer Questions",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF1F1F1),
                                padding: const EdgeInsets.symmetric(vertical: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16), // الحواف متساوية
                                ),
                                minimumSize: const Size(double.infinity, 72),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => WriteFeelingsScreen()), // الانتقال إلى شاشة كتابة المشاعر
                                );
                              },
                              icon: const Icon(
                                Icons.text_fields,
                                color: Colors.black,
                              ), // أيقونة النص
                              label: const Text(
                                "Write What Do You Feel",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF1F1F1),
                                padding: const EdgeInsets.symmetric(vertical: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16), // الحواف متساوية
                                ),
                                minimumSize: const Size(double.infinity, 72),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // زر النكست
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24), // إضافة padding ليكون متناسب
              child: ElevatedButton(
                onPressed: () {}, // يمكنك إضافة أي وظيفة هنا
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9616FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // جعل الزر بنفس شكل الأزرار الأخرى
                  ),
                  minimumSize: const Size(double.infinity, 72), // تأكيد العرض الكامل والارتفاع
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 15), // مسافة بين زرار النكست والهوم انديكيتور
          ],
        ),
      ),
    );
  }
}