import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moodmate/screens/Feeling%20selection%20screen.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;
  String? _imagePath;
  Interpreter? _interpreter;
  List<String> emotions = ["Angry", "Disgust", "Fear", "Happy", "Neutral", "Sad", "Surprise"];
  String? _predictedEmotion;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/emotiondetector_model.tflite');
    } catch (e) {
      print("خطأ أثناء تحميل النموذج: $e");
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      _controller = CameraController(_cameras[0], ResolutionPreset.high);
      await _controller.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print("خطأ أثناء تهيئة الكاميرا: $e");
    }
  }

  Future<void> _takePicture() async {
    try {
      final XFile image = await _controller.takePicture();
      setState(() {
        _imagePath = image.path;
      });
    } catch (e) {
      print("خطأ أثناء التقاط الصورة: $e");
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
        });
      }
    } catch (e) {
      print("خطأ أثناء اختيار الصورة: $e");
    }
  }

  Future<String?> _classifyImage(File imageFile) async {
    try {
      final img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
      final img.Image resized = img.copyResize(image, width: 48, height: 48);

      List<List<List<List<double>>>> input = [
        List.generate(
          48,
              (i) => List.generate(
            48,
                (j) {
              img.Color pixel = resized.getPixel(j, i);
              double grayscaleValue = img.getLuminance(pixel) / 255.0;
              return [grayscaleValue];
            },
          ),
        ),
      ];

      var output = List.filled(7, 0.0).reshape([1, 7]);

      _interpreter?.run(input, output);

      int maxIndex = output[0].indexOf(output[0].reduce((double a, double b) => a > b ? a : b));
      setState(() {
        _predictedEmotion = emotions[maxIndex];
      });

      print('🔍 Detected Emotion: $_predictedEmotion');
      return _predictedEmotion;
    } catch (e) {
      print("❌ خطأ أثناء تصنيف الصورة: $e");
      return null;
    }
  }

  void _onDonePressed() async {
    if (_imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No image selected!")),
      );
      return;
    }

    String? detectedEmotion = await _classifyImage(File(_imagePath!));

    if (detectedEmotion != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FeelingSelectionScreen(userFeeling: detectedEmotion),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Take A Picture', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: !_isCameraInitialized
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: 382,
              height: 485,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: _imagePath != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.file(File(_imagePath!), fit: BoxFit.cover),
              )
                  : CameraPreview(_controller),
            ),
            SizedBox(height: 20),
            if (_predictedEmotion != null)
              Text("Detected Emotion: $_predictedEmotion",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _pickImageFromGallery,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/gallery.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _takePicture,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 4),
                    ),
                  ),
                ),
                SizedBox(width: 70),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onDonePressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9616FF),
                minimumSize: Size(382, 70),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text('Done', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            SizedBox(height: 10),
            Container(width: 430, height: 21, color: Colors.transparent),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _interpreter?.close();
    super.dispose();
  }
}
