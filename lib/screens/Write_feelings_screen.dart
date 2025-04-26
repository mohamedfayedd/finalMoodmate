import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class EmotionTextDetectionScreen extends StatefulWidget {
  const EmotionTextDetectionScreen({Key? key}) : super(key: key);

  @override
  _EmotionTextDetectionScreenState createState() => _EmotionTextDetectionScreenState();
}

class _EmotionTextDetectionScreenState extends State<EmotionTextDetectionScreen> {
  late Interpreter _interpreter;
  late List<int> _inputShape;
  late List<int> _outputShape;
  bool _isProcessing = false;
  String _result = '';
  final TextEditingController _controller = TextEditingController();

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
      _inputShape = _interpreter.getInputTensor(0).shape;
      _outputShape = _interpreter.getOutputTensor(0).shape;

      debugPrint('✅ Model loaded');
      debugPrint('Input Shape: $_inputShape');
      debugPrint('Output Shape: $_outputShape');
    } catch (e) {
      debugPrint('❌ Failed to load model: $e');
    }
  }

  Future<void> _predictEmotion(String text) async {
    if (text.trim().isEmpty || _isProcessing) return;

    setState(() {
      _isProcessing = true;
      _result = '';
    });

    try {
      await Future.delayed(const Duration(milliseconds: 500)); // UX delay

      final input = _preprocessInput(text);

      final output = List.filled(_outputShape.reduce((a, b) => a * b), 0.0)
          .reshape([_outputShape[0], _outputShape[1]]);

      _interpreter.run(input, output);

      debugPrint('🔍 Raw model output: $output');

      final predictedIndex = _argMax(output[0]);
      final predictedEmotion = _labels[predictedIndex];

      setState(() {
        _result = predictedEmotion;
      });
    } catch (e) {
      debugPrint('❌ Inference error: $e');
      setState(() {
        _result = 'Error during detection.';
      });
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  List<List<double>> _preprocessInput(String text) {
    final features = _inputShape[1];
    List<double> vector = List.filled(features, 0.0);

    for (int i = 0; i < text.length && i < features; i++) {
      vector[i] = text.codeUnitAt(i) / 255.0;
    }

    return [vector];
  }

  int _argMax(List<double> list) {
    double maxVal = list[0];
    int maxIndex = 0;

    for (int i = 1; i < list.length; i++) {
      if (list[i] > maxVal) {
        maxVal = list[i];
        maxIndex = i;
      }
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
                onChanged: (text) {
                  setState(() {});
                },
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
            if (_result.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Predicted Emotion:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _result,
                style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
              ),
            ],
            const Spacer(),
            Container(
              width: 382,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFF9616FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: _isProcessing ? null : () => _predictEmotion(_controller.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                ),
                child: _isProcessing
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
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
