import 'package:flutter/material.dart';
import 'Home_screen.dart';
import 'treatment_suggestions_screen.dart';

class RateMoodScreen extends StatefulWidget {
  @override
  _RateMoodScreenState createState() => _RateMoodScreenState();
}

class _RateMoodScreenState extends State<RateMoodScreen> {
  double _sliderValue = 0.5;
  bool _isRated = false;

  Color _getSliderColor(double value) {
    if (value >= 0.8) return Colors.green;
    if (value >= 0.6) return Colors.yellow;
    if (value >= 0.4) return Colors.grey[600]!;
    if (value >= 0.2) return Colors.orange.withOpacity(0.7);
    return Colors.red;
  }

  void _showRateWarning() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Text(
          "Please rate your mood",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "OK",
                style: TextStyle(color: Colors.purple, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleBack() {
    if (_isRated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      _showRateWarning();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Rate Mood Progress",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: _handleBack,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "How would you rate your new mood?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Excellent"),
                          SizedBox(height: 80),
                          Text("Good"),
                          SizedBox(height: 70),
                          Text("Fair"),
                          SizedBox(height: 70),
                          Text("Poor"),
                          SizedBox(height: 70),
                          Text("Worst"),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 16,
                                height: (1 - _sliderValue) * 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(100)),
                                  color: Colors.grey[300],
                                ),
                              ),
                              Container(
                                width: 16,
                                height: _sliderValue * 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(100)),
                                  color: _getSliderColor(_sliderValue),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: (1 - _sliderValue) * 400 - 25,
                            child: GestureDetector(
                              onVerticalDragUpdate: (details) {
                                setState(() {
                                  _sliderValue -= details.primaryDelta! / 400;
                                  _sliderValue = _sliderValue.clamp(0.0, 1.0);
                                  _isRated = true;
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey, width: 3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(width: 32, height: 32, margin: EdgeInsets.symmetric(vertical: 30), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8))),
                          Container(width: 32, height: 32, margin: EdgeInsets.symmetric(vertical: 30), decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(8))),
                          Container(width: 32, height: 32, margin: EdgeInsets.symmetric(vertical: 30), decoration: BoxDecoration(color: Colors.grey[600], borderRadius: BorderRadius.circular(8))),
                          Container(width: 32, height: 32, margin: EdgeInsets.symmetric(vertical: 30), decoration: BoxDecoration(color: Colors.orange.withOpacity(0.7), borderRadius: BorderRadius.circular(8))),
                          Container(width: 32, height: 32, margin: EdgeInsets.symmetric(vertical: 30), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(382, 70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.purple,
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TreatmentSuggestionsScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(382, 70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: BorderSide(color: Colors.purple),
                  ),
                  child: Text("Choose Another Treatment", style: TextStyle(color: Colors.purple)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}