import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WatchVideoScreen extends StatefulWidget {
  @override
  _WatchVideoScreenState createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen>
    with SingleTickerProviderStateMixin {
  final List<String> tabs = [
    "Suggested",
    "Gaming",
    "Advertisements",
    "Music",
    "Technology",
    "Sports"
  ];

  final List<List<Map<String, String>>> videoData = [
    [
      {"title": "Never Gonna Give You Up", "url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"},
      {"title": "Counting Stars", "url": "https://www.youtube.com/watch?v=3JZ_D3ELwOQ"},
      {"title": "Smooth Criminal", "url": "https://www.youtube.com/watch?v=L_jWHffIx5E"}
    ],
    [
      {"title": "Uptown Funk", "url": "https://www.youtube.com/watch?v=fLexgOxsZu0"},
      {"title": "Billie Jean", "url": "https://www.youtube.com/watch?v=Zi_XLOBDo_Y"},
      {"title": "Despacito", "url": "https://www.youtube.com/watch?v=kJQP7kiw5Fk"}
    ],
    [
      {"title": "Funny Commercial", "url": "https://www.youtube.com/watch?v=R2zXfR2vB2g"},
      {"title": "Happy Song", "url": "https://www.youtube.com/watch?v=OPf0YbXqDm0"},
      {"title": "Shape of You", "url": "https://www.youtube.com/watch?v=JGwWNGJdvx8"}
    ],
    [
      {"title": "Sugar", "url": "https://www.youtube.com/watch?v=09R8_2nJtjg"},
      {"title": "Can't Stop the Feeling", "url": "https://www.youtube.com/watch?v=ru0K8uYEZWw"},
      {"title": "Dancing Video", "url": "https://www.youtube.com/watch?v=RqtgfjkB6Pg"}
    ],
    [
      {"title": "Tech Talk", "url": "https://www.youtube.com/watch?v=G2_XcN2RfJ0"},
      {"title": "Coding Tutorial", "url": "https://www.youtube.com/watch?v=LsoLEjrDogU"},
      {"title": "AI Revolution", "url": "https://www.youtube.com/watch?v=Y1_VsyLAGuk"}
    ],
    [
      {"title": "Best Goals", "url": "https://www.youtube.com/watch?v=R2zXfR2vB2g"},
      {"title": "Epic Match", "url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"},
      {"title": "Top 10 Moments", "url": "https://www.youtube.com/watch?v=L_jWHffIx5E"}
    ]
  ];

  late TabController _tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openVideo(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // جعل الخلفية بيضاء
      appBar: AppBar(
        title: Text("Watch Videos", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(
                      tabs[index],
                      style: TextStyle(
                        color: selectedTabIndex == index
                            ? Colors.purple
                            : Colors.black,
                      ),
                    ),
                    selected: selectedTabIndex == index,
                    selectedColor: Colors.purple.shade100,
                    backgroundColor: Colors.grey.shade200,
                    shape: StadiumBorder(side: BorderSide(color: Colors.transparent)), // إزالة الحواف السوداء
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          selectedTabIndex = index;
                          _tabController.animateTo(index);
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.asMap().entries.map((entry) {
          int index = entry.key;
          return ListView(
            padding: EdgeInsets.all(16),
            children: videoData[index].map((video) {
              return GestureDetector(
                onTap: () => _openVideo(video["url"]!),
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                              "https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(video["url"]!)}/0.jpg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            ),
                            Icon(
                              Icons.play_circle_fill,
                              size: 60,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          video["title"]!,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
