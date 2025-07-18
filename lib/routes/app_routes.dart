import 'package:get/get.dart';
import 'package:whatsapp/features/auth/views/login_page.dart';
import 'package:whatsapp/features/auth/views/registeration_page.dart';
import 'package:whatsapp/features/auth/views/splash_screen.dart';
import 'package:whatsapp/features/chat/views/message_page.dart';
import 'package:whatsapp/features/chat/views/dashboard_page.dart';

class AppRoutes {
  static final String splash = '/';
  static final String login = '/login';
  static final String register = '/register';
  static final String home = '/dashboard';
  static final String call = '/call';
  static final String chat = '/chat';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: register, page: () => RegistrationPage()),
    GetPage(name: home, page: () => DashboardPage()),
    GetPage(name: call, page: () => MessagePage()),
    // GetPage(name: chat, page: () => Chat()),
  ];
}
