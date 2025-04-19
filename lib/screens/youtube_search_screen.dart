import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'watch_video_screen.dart';

class YoutubeSearchScreen extends StatefulWidget {
  final String query;

  YoutubeSearchScreen({required this.query});

  @override
  _YoutubeSearchScreenState createState() => _YoutubeSearchScreenState();
}

class _YoutubeSearchScreenState extends State<YoutubeSearchScreen> {
  List<String> videoIds = [];
  final String apiKey = 'AIzaSyD4paaLtLe7HxLqaBodb5HGM5gEiwnO2iI';

  @override
  void initState() {
    super.initState();
    _searchVideos(widget.query);
  }

  Future<void> _searchVideos(String query) async {
    final url = Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&type=video&maxResults=10&key=$apiKey');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> ids = [];
      for (var item in data['items']) {
        ids.add(item['id']['videoId']);
      }
      setState(() {
        videoIds = ids;
      });
    } else {
      print('Failed to fetch videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Search Results", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: videoIds.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: videoIds.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Video ${index + 1}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WatchVideoScreen(videoIds: videoIds), // ✅ تمرير الفيديوهات
                ),
              );
            },
          );
        },
      ),
    );
  }
}
