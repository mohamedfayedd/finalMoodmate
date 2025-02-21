import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:moodmate/screens/view_book.dart';
import 'loadingscreen.dart';

class ReadBooksScreen extends StatefulWidget {
  @override
  _ReadBooksScreenState createState() => _ReadBooksScreenState();
}

class _ReadBooksScreenState extends State<ReadBooksScreen> {
  final List<String> categories = [
    'Suggested',
    'Novels',
    'Non-Fiction',
    'Self-Help',
    'Psychology',
    'Motivational'
  ];

  final Map<String, String> subjectMapping = {
    'Suggested': 'fiction',
    'Novels': 'novels',
    'Non-Fiction': 'nonfiction',
    'Self-Help': 'self_help',
    'Psychology': 'psychology',
    'Motivational': 'motivational',
  };

  String selectedCategory = 'Suggested';
  Map<String, List<dynamic>> booksData = {};

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final subject = subjectMapping[selectedCategory] ?? selectedCategory.toLowerCase();
    try {
      var response = await Dio().get(
          'https://www.googleapis.com/books/v1/volumes?q=subject:$subject&maxResults=16'
      );
      List<dynamic> books = response.data['items'] ?? [];

      setState(() {
        booksData[selectedCategory] = books;
      });
    } catch (e) {
      print('Error fetching books: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            _buildCategorySelector(),
            SizedBox(height: 24),
            Expanded(child: _buildBooksGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Read Books',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String category = categories[index];
          bool isSelected = selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
              fetchBooks();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 9),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFFEDE1FF) : Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Color(0xFF9616FF) : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBooksGrid() {
    List<dynamic> books = booksData[selectedCategory] ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 150 / 220,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          var book = books[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoadingScreen(book: book),
                ),
              ).then((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewBookScreen(book: book),
                  ),
                );
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    book['volumeInfo']['imageLinks'] != null
                        ? book['volumeInfo']['imageLinks']['thumbnail']
                        : 'https://via.placeholder.com/150x220',
                    width: 150,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  book['volumeInfo']['title'] ?? 'No Title',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
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
