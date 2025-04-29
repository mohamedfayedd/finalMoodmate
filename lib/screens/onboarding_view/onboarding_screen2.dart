import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'onboarding_screen3.dart'; // تأكد من استيراد الشاشة الثالثة

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0), // إضافة هوامش حول المحتوى
          child: Column(
            children: [
              // زر "Skip" في أعلى يمين الحاوية
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    // الانتقال إلى الشاشة الثالثة
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingScreen3(), // انتقل إلى الشاشة الثالثة
                      ),
                    );
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // حاوية الصورة
              Expanded(
                flex: 2,
                child: SvgPicture.asset(
                  "assets/images/onBoarding2.svg", // مسار الصورة
                  width: 400, // عرض الصورة
                  height: 500, // ارتفاع الصورة
                  fit: BoxFit.contain,
                ),
              ),
              // حاوية النص
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // لتوسيط النص
                  children: [
                    const Text(
                      "How it works",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Describe your mood, answer questions, or upload a photo to get tailored suggestions.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              // مؤشر التنقل (ثلاث نقاط)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0), // هوامش أسفل المؤشر
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildIndicator(isActive: false), // النقطة الأولى (غير نشطة)
                    const SizedBox(width: 4), // المسافة بين النقاط
                    buildIndicator(isActive: true), // النقطة الثانية (نشطة)
                    const SizedBox(width: 4), // المسافة بين النقاط
                    buildIndicator(isActive: false), // النقطة الثالثة (غير نشطة)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator({required bool isActive}) {
    return Container(
      width: isActive ? 12 : 6, // عرض النقطة (12 إذا كانت نشطة، 6 إذا كانت غير نشطة)
      height: 6, // ارتفاع النقطة
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey, // اللون (أسود إذا كانت نشطة، رمادي إذا كانت غير نشطة)
        borderRadius: BorderRadius.circular(3), // شكل النقطة
      ),
    );
  }
}
