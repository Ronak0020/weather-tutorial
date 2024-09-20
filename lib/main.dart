import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:weatherapp_piyush/pages/home_page.dart';
import 'package:weatherapp_piyush/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
        fontFamily: "Gilroy"
      ),
      home: const SplashPage(),
    );
  }
}
