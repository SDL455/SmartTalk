import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/cores/services/user_service.dart';
import 'package:whatsapp/cores/models/user.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
    UserService userService = UserService();
    UserModel? user = await userService.loadUser();
    await Future.delayed(Duration(seconds: 2)); // Optional: show splash for 2s
    if (user != null) {
      Get.offAllNamed('/dashboard');
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF075E54),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(Icons.chat_bubble, size: 80, color: Colors.white),
            Image.asset('icons/icon_use.jpeg', width: 100, height: 100),
            SizedBox(height: 20),
            Text(
              'SmartTalk',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
