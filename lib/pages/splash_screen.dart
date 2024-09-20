import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp_piyush/controllers/homepage_controller.dart';
import 'package:weatherapp_piyush/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final HomePageController controller = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      await controller.getLocation();
      Future.delayed(Duration(seconds: 5), () {
        Get.off(() => HomePage());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(Icons.cloud, size: 50),
      ),
    );
  }
}
