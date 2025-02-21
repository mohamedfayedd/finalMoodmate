import 'package:flutter/material.dart';
import 'dart:math';
import 'play_surah.dart'; // استيراد صفحة التشغيل

class ListenQuran extends StatefulWidget {
  @override
  _ListenQuranState createState() => _ListenQuranState();
}

class _ListenQuranState extends State<ListenQuran> {
  final List<String> surahs = [
    "Al-Faatiha", "Al-Baqara", "Aal-i-Imraan", "An-Nisaa", "Al-Maaida",
    "Al-An'aam", "Al-A'raaf", "Al-Anfaal", "At-Tawba", "Yunus",
    "Hud", "Yusuf", "Ar-Ra'd", "Ibrahim", "Al-Hijr",
    "An-Nahl", "Al-Israa", "Al-Kahf", "Maryam", "Taha",
    "Al-Anbiyaa", "Al-Hajj", "Al-Mu'minoon", "An-Noor", "Al-Furqaan",
    "Ash-Shu'araa", "An-Naml", "Al-Qasas", "Al-Ankaboot", "Ar-Room",
    "Luqman", "As-Sajda", "Al-Ahzaab", "Saba", "Fatir",
    "Ya-Sin", "As-Saffat", "Sad", "Az-Zumar", "Ghafir",
    "Fussilat", "Ash-Shura", "Az-Zukhruf", "Ad-Dukhan", "Al-Jathiya",
    "Al-Ahqaf", "Muhammad", "Al-Fath", "Al-Hujraat", "Qaf",
    "Adh-Dhariyat", "At-Tur", "An-Najm", "Al-Qamar", "Ar-Rahman",
    "Al-Waqia", "Al-Hadid", "Al-Mujadila", "Al-Hashr", "Al-Mumtahina",
    "As-Saff", "Al-Jumu'a", "Al-Munafiqun", "At-Taghabun", "At-Talaq",
    "At-Tahrim", "Al-Mulk", "Al-Qalam", "Al-Haaqqa", "Al-Ma'arij",
    "Nuh", "Al-Jinn", "Al-Muzzammil", "Al-Muddaththir", "Al-Qiyama",
    "Al-Insan", "Al-Mursalat", "An-Naba", "An-Nazi'at", "Abasa",
    "At-Takwir", "Al-Infitar", "Al-Mutaffifin", "Al-Inshiqaq", "Al-Burooj",
    "At-Tariq", "Al-A'la", "Al-Ghashiya", "Al-Fajr", "Al-Balad",
    "Ash-Shams", "Al-Lail", "Ad-Duhaa", "Ash-Sharh", "At-Tin",
    "Al-Alaq", "Al-Qadr", "Al-Bayyina", "Az-Zalzala", "Al-Adiyat",
    "Al-Qari'a", "At-Takathur", "Al-Asr", "Al-Humaza", "Al-Fil",
    "Quraish", "Al-Ma'un", "Al-Kawthar", "Al-Kafiroon", "An-Nasr",
    "Al-Masad", "Al-Ikhlas", "Al-Falaq", "An-Nas"
  ];

  int? playingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Listen To Quran",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle:
        TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          bool isPlaying = playingIndex == index;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 29.5,
                  backgroundColor: Color(0xFFF1F1F1),
                  child: Text("${index + 1}",
                      style: TextStyle(
                          color: Color(0xFF9616FF), fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        surahs[index],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF9616FF)),
                      ),
                      SizedBox(height: 4),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 30,
                        child: isPlaying
                            ? Row(
                          children: List.generate(31, (i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 1.95),
                              child: Container(
                                width: 4,
                                height: Random().nextInt(30) + 10,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9D7AFF),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            );
                          }),
                        )
                            : Text(
                          '------------------------------------------------------',
                          style: TextStyle(
                            color: Color(0xFF9D7AFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaySurah(
                          surahName: surahs[index],
                          surahIndex: index,
                          wasPlaying: playingIndex == index,
                        ),
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        playingIndex = result['isPlaying'] ? result['index'] : null;
                      });
                    }
                  },
                  child: CircleAvatar(
                    radius: 29.5,
                    backgroundColor:
                    isPlaying ? Color(0xFFEDE1FF) : Color(0x339D7AFF),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Color(0xFF9D7AFF),
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}