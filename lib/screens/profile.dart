import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkTheme = false;
  bool allowNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Your profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Column(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                SizedBox(height: 8),
                Text(
                  'Mohamed Fayed',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                buildButton('View Statistics', Icons.bar_chart, Color(0xFF9616FF)),
                SizedBox(height: 16),
                buildSettingOption('App Language', 'english', null, 50),
                SizedBox(height: 8),
                buildSettingOption(
                  'Dark Theme',
                  null,
                  Switch(
                    value: isDarkTheme,
                    onChanged: (value) {
                      setState(() {
                        isDarkTheme = value;
                      });
                    },
                  ),
                  50,
                ),
                SizedBox(height: 8),
                buildSettingOption(
                  'Allow Notifications',
                  null,
                  Switch(
                    value: allowNotifications,
                    onChanged: (value) {
                      setState(() {
                        allowNotifications = value;
                      });
                    },
                  ),
                  50,
                ),
              ],
            ),
            Spacer(),
            buildButton('Logout', null, Color(0xFFFF0000)),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text, IconData? icon, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, color: Colors.white),
          if (icon != null) SizedBox(width: 10),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }

  Widget buildSettingOption(String title, String? value, Widget? trailing, double height) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          trailing ?? Text(value ?? '', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
