import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:moodmate/screens/detected_mood_view/detected_mood_view.dart';

class EmotionTextDetectionScreen extends StatefulWidget {
  const EmotionTextDetectionScreen({Key? key}) : super(key: key);

  @override
  _EmotionTextDetectionScreenState createState() =>
      _EmotionTextDetectionScreenState();
}

class _EmotionTextDetectionScreenState extends State<EmotionTextDetectionScreen> {
  late Interpreter _interpreter;
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  Map<String, int> _vocab = {};
  final int _features = 5000; // Ensure this matches training

  final List<String> _labels = [
    'anger', 'disgust', 'fear', 'joy', 'neutral', 'sadness', 'surprise'
  ];

  @override
  void initState() {
    super.initState();
    _loadModelAndVocab();
  }

  Future<void> _loadModelAndVocab() async {
    try {
      // Load the model from assets
      _interpreter = await Interpreter.fromAsset(
        'assets/text_emotion_model/emotion_model.tflite',
      );

      // Load the vocabulary from assets
      final vocabJson = await rootBundle.loadString('assets/text_emotion_model/vocab.json');
      final Map<String, dynamic> jsonMap = jsonDecode(vocabJson);
      _vocab = jsonMap.map((key, value) => MapEntry(key, value as int));

      debugPrint('✅ Model and vocab loaded successfully');
    } catch (e) {
      debugPrint('❌ Failed to load model or vocab: $e');
    }
  }

  Future<String?> _predictEmotion(String text) async {
    if (text.trim().isEmpty) return null;

    setState(() => _isLoading = true);

    try {
      final inputShape = _interpreter.getInputTensor(0).shape;
      final outputShape = _interpreter.getOutputTensor(0).shape;

      // Debugging: Check the shape of the input and output tensors
      debugPrint('Input shape: $inputShape');
      debugPrint('Output shape: $outputShape');

      // Convert the text into the model's expected vector format
      final input = [_vectorizeText(text, _vocab, _features)];

      // Initialize an output buffer
      final output = List.filled(outputShape.reduce((a, b) => a * b), 0.0)
          .reshape([outputShape[0], outputShape[1]]);

      // Run inference
      _interpreter.run(input, output);

      // Debugging: Check the raw output values
      debugPrint('Raw model output: $output');

      final predictedIndex = _argMax(output[0]);
      return _labels[predictedIndex];
    } catch (e) {
      debugPrint('❌ Inference error: $e');
      return null;
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
List<double> _vectorizeText(String text, Map<String, int> vocab, int features) {
  List<double> vector = List.filled(features, 0.0);
  final processedText = _preprocessText(text);
  
  // Implement n-grams (1-3) like Python code
  final words = processedText.split(' ').where((w) => w.isNotEmpty);
  
  // Generate 1-grams, 2-grams, and 3-grams
  final allNgrams = <String>[];
  final wordList = words.toList();
  
  for (int i = 0; i < wordList.length; i++) {
    // 1-gram
    allNgrams.add(wordList[i]);
    
    // 2-gram
    if (i < wordList.length - 1) {
      allNgrams.add('${wordList[i]} ${wordList[i+1]}');
    }
    
    // 3-gram
    if (i < wordList.length - 2) {
      allNgrams.add('${wordList[i]} ${wordList[i+1]} ${wordList[i+2]}');
    }
  }
  
  // Vectorize
  for (var ngram in allNgrams) {
    final index = vocab[ngram];
    if (index != null && index < features) {
      vector[index] += 1.0;
    }
  }
  
  return vector;
}
  int _argMax(List<double> list) {
    int maxIndex = 0;
    for (int i = 1; i < list.length; i++) {
      if (list[i] > list[maxIndex]) maxIndex = i;
    }
    return maxIndex;
  }

String _preprocessText(String text) {
  // 1. Lowercase
  text = text.toLowerCase();
  
  // 2. Remove punctuation (keep only letters and whitespace)
  text = text.replaceAll(RegExp(r'[^a-zA-Z\s]'), ' ');
  
  // 3. Remove stopwords (partial implementation - full list needed)
  final stopwords = {
    'i', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', 'your', 
    'yours', 'yourself', 'yourselves', 'he', 'him', 'his', 'himself', 'she', 
    'her', 'hers', 'herself', 'it', 'its', 'itself', 'they', 'them', 'their', 
    'theirs', 'themselves', 'what', 'which', 'who', 'whom', 'this', 'that', 
    'these', 'those', 'am', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 
    'have', 'has', 'had', 'having', 'do', 'does', 'did', 'doing', 'a', 'an', 
    'the', 'and', 'but', 'if', 'or', 'because', 'as', 'until', 'while', 'of', 
    'at', 'by', 'for', 'with', 'about', 'against', 'between', 'into', 'through', 
    'during', 'before', 'after', 'above', 'below', 'to', 'from', 'up', 'down', 
    'in', 'out', 'on', 'off', 'over', 'under', 'again', 'further', 'then', 
    'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all', 'any', 
    'both', 'each', 'few', 'more', 'most', 'other', 'some', 'such', 'no', 'nor', 
    'not', 'only', 'own', 'same', 'so', 'than', 'too', 'very', 's', 't', 'can', 
    'will', 'just', 'don', 'should', 'now'
  };
  
  // Split, filter stopwords, and rejoin
  final words = text.split(' ').where((word) => 
    word.isNotEmpty && !stopwords.contains(word));
  
  // 4. Stemming (basic implementation - consider porter_stemmer package)
  final stemmedWords = words.map((word) => _simpleStem(word)).toList();
  
  return stemmedWords.join(' ');
}

// Basic stemmer (replace with proper Porter stemming if needed)
String _simpleStem(String word) {
  // Very basic stemming - replace with a proper stemmer package
  if (word.endsWith('ing')) {
    return word.substring(0, word.length - 3);
  } else if (word.endsWith('ly')) {
    return word.substring(0, word.length - 2);
  } else if (word.endsWith('ed')) {
    return word.substring(0, word.length - 2);
  }
  return word;
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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
