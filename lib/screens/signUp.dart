import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'LoginScreen.dart'; // غيّر your_project_name حسب مسار الملف

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 90,
                    height: 90,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Create New Account",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              buildInputField(
                icon: const Text("🇪🇬", style: TextStyle(fontSize: 20)),
                hint: "+1 000 000 000",
              ),
              const SizedBox(height: 16),
              buildInputField(
                icon: const Icon(Icons.email_outlined, color: Colors.grey),
                hint: "Email",
              ),
              const SizedBox(height: 16),
              buildInputField(
                icon: const Icon(Icons.person_outline, color: Colors.grey),
                hint: "full name",
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {
                      print("Remember me toggled");
                    },
                    activeColor: const Color(0xFF9616FF),
                  ),
                  const Text(
                    "Remember me",
                    style: TextStyle(
                      color: Color(0xFF9616FF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // زر التسجيل
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    print("Sign in button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9616FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("or continue with"),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("Facebook icon pressed");
                    },
                    child: buildSocialIcon(Icons.facebook, Colors.blue),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      print("Google icon pressed");
                    },
                    child: buildSocialIcon(Icons.g_mobiledata, Colors.red),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      print("Apple icon pressed");
                    },
                    child: buildSocialIcon(Icons.apple, Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  LoginScreen()),
                      );
                    },
                    child: const Text(
                      "sign in",
                      style: TextStyle(
                        color: Color(0xFF9616FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField({required Widget icon, required String hint}) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSocialIcon(IconData iconData, Color iconColor) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(iconData, size: 28, color: iconColor),
    );
  }
}
