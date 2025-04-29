import 'package:flutter/material.dart';
import 'package:moodmate/screens/detected_mood_view/detected_mood_view.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class EmotionTextDetectionScreen extends StatefulWidget {
  const EmotionTextDetectionScreen({Key? key}) : super(key: key);

  @override
  _EmotionTextDetectionScreenState createState() => _EmotionTextDetectionScreenState();
}

class _EmotionTextDetectionScreenState extends State<EmotionTextDetectionScreen> {
  late Interpreter _interpreter;
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  final List<String> _labels = [
    'anger', 'disgust', 'fear', 'joy', 'neutral', 'sadness', 'surprise'
  ];

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/text_emotion_model/emotion_model.tflite');
      debugPrint('✅ Model loaded successfully');
    } catch (e) {
      debugPrint('❌ Failed to load model: $e');
      // Handle model loading error appropriately
    }
  }

  Future<String?> _predictEmotion(String text) async {
    if (text.trim().isEmpty) return null;

    setState(() => _isLoading = true);

    try {
      // Get model input/output shapes
      final inputShape = _interpreter.getInputTensor(0).shape;
      final outputShape = _interpreter.getOutputTensor(0).shape;

      // Preprocess input
      final input = _preprocessInput(text, inputShape[1]);
      
      // Prepare output buffer
      final output = List.filled(outputShape.reduce((a, b) => a * b), 0.0)
          .reshape([outputShape[0], outputShape[1]]);

      // Run inference
      _interpreter.run(input, output);

      // Get predicted emotion
      final predictedIndex = _argMax(output[0]);
      return _labels[predictedIndex];
    } catch (e) {
      debugPrint('❌ Inference error: $e');
      return null;
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  List<List<double>> _preprocessInput(String text, int features) {
    List<double> vector = List.filled(features, 0.0);
    for (int i = 0; i < text.length && i < features; i++) {
      vector[i] = text.codeUnitAt(i) / 255.0;
    }
    return [vector];
  }

  int _argMax(List<double> list) {
    int maxIndex = 0;
    for (int i = 1; i < list.length; i++) {
      if (list[i] > list[maxIndex]) maxIndex = i;
    }
    return maxIndex;
  }

  @override
  void dispose() {
    _interpreter.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Write what do you feel',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Container(
              width: 382,
              height: 194,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 6,
                maxLength: 500,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: 'Write what do you feel ....',
                  border: InputBorder.none,
                  counterText: "",
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${_controller.text.length} / 500',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const Spacer(),
            Container(
              width: 382,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFF9616FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : () async {
                  final emotion = await _predictEmotion(_controller.text);
                  if (emotion != null && mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetectedModeScreen(emotion: emotion),
                      ),
                    );
                  } else if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to analyze text')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Analyze',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}