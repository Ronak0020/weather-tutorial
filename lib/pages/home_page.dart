import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_piyush/controllers/homepage_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController controller = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
    controller.getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    print(controller.weatherData?.current?.humidity);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.all(10),
              height: 400,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.7,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://w0.peakpx.com/wallpaper/219/837/HD-wallpaper-spring-season-tree-flower-fall.jpg")),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child: SafeArea(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat(DateFormat.MONTH_WEEKDAY_DAY).format(DateTime.now()), style: const TextStyle(fontSize: 25),),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "${controller.weatherData?.current?.humidity ?? "NO"}°C",
                          style: const TextStyle(fontSize: 60),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const Spacer(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Irkutsk",
                            style: TextStyle(fontSize: 22),
                            textAlign: TextAlign.right,
                          ),
                          Icon(Icons.arrow_outward)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    height: 130,
                    width: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  Container(
                    height: 130,
                    width: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  Container(
                    height: 130,
                    width: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 130,
              decoration: BoxDecoration(
                  color: const Color(0xFF212325),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
            color: Color(0xFF212325),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.people, size: 30),
            Icon(Icons.people, size: 30),
            Icon(Icons.people, size: 30)
          ],
        ),
      ),
    );
  }
}
