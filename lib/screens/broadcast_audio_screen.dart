import 'package:flutter/material.dart';

class BroadcastAudioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80, // ✅ زيادة ارتفاع الـ AppBar
        title: Text(
          "Listen To Broadcasts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20, // ✅ تكبير الخط ليكون متناسقًا مع ارتفاع الـ AppBar
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tab Bar
                Container(
                  width: 382.9621887207031,
                  height: 52.86683654785156,
                  padding: EdgeInsets.only(top: 14.18, right: 6.45, bottom: 14.18, left: 6.45),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.47),
                    color: Colors.grey.shade300,
                  ),
                  child: Center(
                    child: Text(
                      "Audios",
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 22, // ✅ تكبير الخط أكثر
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Suggested Section
                Text(
                  "Suggested",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // ✅ تفعيل التمرير العرضي
                    shrinkWrap: true, // ✅ منع أخذ مساحة زائدة
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 327,
                        height: 91,
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.play_circle_fill, color: Colors.purple, size: 32),
                            Text("MedBank Records"),
                            Text("Education"),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),

                // All Categories Section
                Text(
                  "All Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),

          // ✅ استخدم Expanded لمنع Overflow مع تثبيت AppBar و Navigation Bar
          Expanded(
            child: Container(
              color: Colors.white, // ✅ تثبيت الخلفية بيضاء عند التمرير
              child: ListView.builder(
                physics: BouncingScrollPhysics(), // ✅ إزالة التأثيرات الغامقة عند التمرير
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: 382,
                    height: 91,
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.play_circle_fill, color: Colors.purple, size: 32),
                        Text("Broadcast ${index + 1}"),
                        Text("Education"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
