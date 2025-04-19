import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart';

class WriteFeelingsScreen extends StatefulWidget {
  @override
  _WriteFeelingsScreenState createState() => _WriteFeelingsScreenState();
}

class _WriteFeelingsScreenState extends State<WriteFeelingsScreen> {
  final TextEditingController _controller = TextEditingController();
  late Interpreter _interpreter;
  List<String> _labels = [];
  Map<String, int> _vocab = {};
  String? _predictedEmotion;
  final int _inputLength = 256;

  @override
  void initState() {
    super.initState();
    _loadModelAndAssets();
  }

  Future<void> _loadModelAndAssets() async {
    _interpreter = await Interpreter.fromAsset('emotion_model.tflite');

    final labelsString = await rootBundle.loadString('assets/labels.txt');
    _labels = labelsString.trim().split('\n');

    final vocabString = await rootBundle.loadString('assets/vocab.txt');
    for (final line in vocabString.split('\n')) {
      final parts = line.trim().split(' ');
      if (parts.length == 2) {
        _vocab[parts[0]] = int.parse(parts[1]);
      }
    }
    setState(() {});
  }

  List<List<double>> _preprocess(String text) {
    final input = List<double>.filled(_inputLength, _vocab['<PAD>']?.toDouble() ?? 0);
    int index = 0;

    if (_vocab.containsKey('<START>')) {
      input[index++] = _vocab['<START>']!.toDouble();
    }

    for (var token in text.toLowerCase().split(' ')) {
      if (index >= _inputLength) break;
      input[index++] = _vocab[token]?.toDouble() ?? (_vocab['<UNKNOWN>']?.toDouble() ?? 0);
    }

    return [input];
  }

  Future<void> _analyzeText() async {
    final input = _preprocess(_controller.text.trim());
    final output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);

    _interpreter.run(input, output);
    final result = output[0];
    final maxIdx = result.indexWhere((x) => x == result.reduce((a, b) => a > b ? a : b));

    setState(() {
      _predictedEmotion = _labels[maxIdx];
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
          'Write what do you feel',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
                  hintText: 'Write what do you feel ....',
                  border: InputBorder.none,
                  counterText: "",
                ),
                onChanged: (text) {
                  setState(() {});
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
            if (_predictedEmotion != null) ...[
              SizedBox(height: 24),
              Text(
                'Predicted Emotion:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                _predictedEmotion!,
                style: TextStyle(fontSize: 20, color: Colors.deepPurple),
              ),
            ],
            Spacer(),
            Container(
              width: 382,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFF9616FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: _analyzeText,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                ),
                child: Text(
                  'Analyze',
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
