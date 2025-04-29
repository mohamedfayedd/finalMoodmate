import 'package:flutter/material.dart';
import 'package:moodmate/screens/detected_mood_view/tips_guide_view.dart';
import 'detect_tips_guide_model.dart';

class DetectedModeScreen extends StatelessWidget {
  final String emotion;

  const DetectedModeScreen({Key? key, required this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moodData = moodGuidance[emotion] ?? moodGuidance['neutral']!;
    final tips = moodData['tips'] as List<String>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Detected Mood',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              'You Seem To Be Feeling',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            Text(
              emotion[0].toUpperCase() + emotion.substring(1),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: moodData['color'] as Color,
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TipsAndGuidanceScreen( ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      (moodData['color'] as Color).withOpacity(0.8),
                      (moodData['color'] as Color).withOpacity(0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tips and Guidance for ${emotion[0].toUpperCase() + emotion.substring(1)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: tips.map((tip) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          '• $tip',
                          style: const TextStyle(color: Colors.white),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Add treatment suggestions navigation
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: moodData['color'] as Color,
              ),
              child: const Text(
                'Treatment Suggestions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.red, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}