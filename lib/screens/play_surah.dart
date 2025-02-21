import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/widgets.dart';

class PlaySurah extends StatefulWidget {
  final int surahIndex;
  final String surahName;
  final bool wasPlaying;

  const PlaySurah({Key? key, required this.surahIndex, required this.surahName, required this.wasPlaying}) : super(key: key);

  @override
  _PlaySurahState createState() => _PlaySurahState();
}

class _PlaySurahState extends State<PlaySurah> {
  late int currentSurahIndex;
  late String currentSurahName;
  bool isPlaying = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    currentSurahIndex = widget.surahIndex;
    currentSurahName = widget.surahName;
    isPlaying = widget.wasPlaying;
    _playSurah();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSurah() async {
    String url = "https://server8.mp3quran.net/afs/${(currentSurahIndex + 1).toString().padLeft(3, '0')}.mp3";

    print("Trying to play: $url");
    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print("Error playing surah: $e");
    }
  }

  void _togglePlayPause() {
    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void changeSurah(bool next) async {
    setState(() {
      if (next) {
        if (currentSurahIndex < 113) {
          currentSurahIndex++;
        }
      } else {
        if (currentSurahIndex > 0) {
          currentSurahIndex--;
        }
      }
      currentSurahName = surahNames[currentSurahIndex];
    });
    await _audioPlayer.stop();
    _playSurah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, {'index': currentSurahIndex, 'isPlaying': isPlaying}),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "${currentSurahIndex + 1}",
                  style: TextStyle(
                    fontSize: 96,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9616FF),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              currentSurahName,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9616FF),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 226,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous, size: 40, color: Color(0xFF9616FF)),
                    onPressed: () => changeSurah(false),
                  ),
                  GestureDetector(
                    onTap: _togglePlayPause,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFF9616FF),
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next, size: 40, color: Color(0xFF9616FF)),
                    onPressed: () => changeSurah(true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> surahNames = [
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
  "As-Saff", "Al-Jumu'a", "Al-Munafiqoon", "At-Taghabun", "At-Talaq",
  "At-Tahrim", "Al-Mulk", "Al-Qalam", "Al-Haaqqa", "Al-Ma'arij",
  "Nuh", "Al-Jinn", "Al-Muzzammil", "Al-Muddaththir", "Al-Qiyama",
  "Al-Insan", "Al-Mursalat", "An-Naba", "An-Nazi'aat", "Abasa",
  "At-Takwir", "Al-Infitar", "Al-Mutaffifin", "Al-Inshiqaq", "Al-Burooj",
  "At-Tariq", "Al-A'la", "Al-Ghashiya", "Al-Fajr", "Al-Balad",
  "Ash-Shams", "Al-Lail", "Ad-Duhaa", "Ash-Sharh", "At-Tin",
  "Al-Alaq", "Al-Qadr", "Al-Bayyina", "Az-Zalzala", "Al-Adiyat",
  "Al-Qari'a", "At-Takathur", "Al-Asr", "Al-Humaza", "Al-Fil",
  "Quraish", "Al-Ma'un", "Al-Kawthar", "Al-Kafiroon", "An-Nasr",
  "Al-Masad", "Al-Ikhlas", "Al-Falaq", "An-Nas"
];