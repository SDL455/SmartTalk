import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartTalk',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF075E54),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF075E54)),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}
