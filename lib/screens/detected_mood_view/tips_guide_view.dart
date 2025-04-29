import 'package:flutter/material.dart';

class TipsAndGuidanceScreen extends StatelessWidget {
  const TipsAndGuidanceScreen({Key? key}) : super(key: key);

  Widget buildTipCard(String title, List<String> points) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: points.map((point) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 14)),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          'Tips and Guidance',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildTipCard(
              "1- Deep breathing can help calm your mind and body. Try this simple exercise",
              [
                "Sit or lie down in a comfortable position.",
                "Place one hand on your chest and the other on your stomach.",
                "Inhale slowly through your nose for 4 seconds, feeling your stomach rise.",
                "Hold your breath for 4 seconds.",
                "Exhale slowly through your mouth for 6 seconds, feeling your stomach fall.",
                "Repeat for 5–10 minutes.",
              ],
            ),
            buildTipCard(
              "2- Progressive muscle relaxation can reduce physical tension caused by anxiety",
              [
                "Start by tensing the muscles in your toes for 5 seconds, then release.",
                "Move up to your calves, thighs, stomach, chest, arms, and face.",
                "Tense and release each muscle group.",
                "Focus on the sensation of relaxation as you release the tension.",
              ],
            ),
            buildTipCard(
              "3- Listening to calming music or nature sounds can help soothe your mind",
              [
                "Choose soft instrumental music, nature sounds, or guided meditation tracks.",
                "Close your eyes and focus on the sounds to distract yourself from anxious thoughts.",
              ],
            ),
            buildTipCard(
              "4- Mindfulness and meditation can help you stay grounded in the present moment",
              [
                "Find a quiet space and sit comfortably.",
                "Focus on your breath or a calming word/phrase (e.g., 'peace' or 'calm').",
                "If your mind wanders, gently bring your focus back.",
                "Start with 5 minutes and gradually increase the duration.",
              ],
            ),
            buildTipCard(
              "5- Journaling can help you process and release anxious thoughts",
              [
                "Write down what’s making you feel anxious.",
                "Try to identify any patterns or triggers.",
                "End your journaling session by listing 3 things you're grateful for to shift your focus to positivity.",
              ],
            ),
          ],
        ),
      ),
    );
  }
}
