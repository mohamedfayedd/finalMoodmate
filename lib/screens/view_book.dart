import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewBookScreen extends StatefulWidget {
  final dynamic book;
  const ViewBookScreen({Key? key, required this.book}) : super(key: key);

  @override
  _ViewBookScreenState createState() => _ViewBookScreenState();
}

class _ViewBookScreenState extends State<ViewBookScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.book['volumeInfo']['previewLink'] ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    String bookTitle = widget.book['volumeInfo']['title'] ?? 'Book Title';
    String previewLink = widget.book['volumeInfo']['previewLink'] ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              width: double.infinity,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(width: 0.33, color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        bookTitle,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
            ),
            // عرض محتوى الكتاب
            Expanded(
              child: previewLink.isNotEmpty
                  ? WebViewWidget(controller: _controller)
                  : Center(
                child: Text("No preview available", style: TextStyle(fontSize: 16, color: Colors.black87)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
