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
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                height: 400,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.7,
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/summer_image.jpg")),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat(DateFormat.MONTH_WEEKDAY_DAY)
                            .format(DateTime.now()),
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          controller.weatherData?.location?.name ?? "...",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "${controller.weatherData?.current?.tempC ?? "NO"}°C",
                          style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Gilroy Bold"),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Real Feel ${controller.weatherData?.current?.feelslikeC ?? "NO"}°C",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: GridView(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  // scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xFF5796fe), Color(0xFFb088fd)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.wind_power),
                          const SizedBox(height: 5),
                          const Text("Wind"),
                          Text(
                            "${controller.weatherData?.current?.windKph ?? "Loading..."} km/h",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xFF5796fe), Color(0xFFb088fd)],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.thermostat),
                          const SizedBox(height: 5),
                          const Text("Pressure"),
                          Text(
                            "${controller.weatherData?.current?.pressureMb?.toInt() ?? "Loading..."} mb",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xFF5796fe), Color(0xFFb088fd)],
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.water_drop),
                          const SizedBox(height: 5),
                          const Text("Humidity"),
                          Text(
                            "${controller.weatherData?.current?.humidity ?? "Loading..."}%",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 130,
                decoration: BoxDecoration(
                    color: const Color(0xFF212325),
                    borderRadius: BorderRadius.circular(30)),
                child: ListView.builder(
                    itemCount: (controller
                                .weatherData?.forecast?.forecastday?[0].hour ??
                            [])
                        .length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "${DateTime.fromMillisecondsSinceEpoch((controller.weatherData?.forecast?.forecastday?[0].hour?[index].timeEpoch ?? 0) * 1000).hour}:00"),
                            Image.network(
                                "https:${controller.weatherData?.forecast?.forecastday?[0].hour?[index].condition?.icon ?? "//cdn-icons-png.flaticon.com/512/5726/5726775.png"}"),
                            Text(
                                "${controller.weatherData?.forecast?.forecastday?[0].hour?[index].tempC}°C")
                          ],
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 8),
              Container(
                // height: 200,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 15).copyWith(top: 20),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: const Color(0xFF212325),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("10 Days Forecast",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    ListView.separated(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            (controller.weatherData?.forecast?.forecastday ??
                                    [])
                                .length,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.grey.shade800,
                          );
                        },
                        itemBuilder: (context, index) {
                          final day = controller
                              .weatherData!.forecast!.forecastday![index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                DateFormat(DateFormat.ABBR_MONTH_DAY)
                                    .format(DateTime.parse(day.date ?? "")),
                                style: const TextStyle(fontSize: 13),
                              ),
                              Image.network(
                                  "https:${controller.weatherData?.forecast?.forecastday?[0].hour?[index].condition?.icon ?? "//cdn-icons-png.flaticon.com/512/5726/5726775.png"}"),
                              Text("${day.day!.maxtempC!.round()}°",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Container(
                                  height: 1,
                                  width: 30,
                                  color: Colors.grey.shade600),
                              Text("${day.day!.mintempC!.round()}°",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold)),
                              Text(day.day!.condition!.text!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold)),
                            ],
                          );
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   width: MediaQuery.of(context).size.width,
      //   padding: const EdgeInsets.symmetric(vertical: 10),
      //   decoration: const BoxDecoration(
      //       color: Color(0xFF212325),
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      //   child: const Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Icon(Icons.sunny, size: 30),
      //       Icon(Icons.compass_calibration, size: 30),
      //       Icon(Icons.emoji_emotions, size: 30)
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade700,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.sunny, size: 30), label: "sunny"),
          BottomNavigationBarItem(icon: Icon(Icons.compass_calibration, size: 30), label: "compass"),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions, size: 30), label: "emotions"),
        ],
      ),
    );
  }
}
