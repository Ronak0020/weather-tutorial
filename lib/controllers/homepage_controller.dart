import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weatherapp_piyush/models/weather_data_model/weather_data_model.dart';

class HomePageController extends GetxController {
  final Dio dio = Dio();
  final String apiKey = "88d43b3b3f3e4135ae085629240709";
  final _weatherData = Rxn<WeatherDataModel>();
  final _position = Rxn<Position>();

  WeatherDataModel? get weatherData => _weatherData.value;

  getWeatherData() async {
    final perm = await getLocation();
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      Get.snackbar("Location Permission Denied!",
          "The location permissions are permanently denied for the application! Kindly enable them from the app settings!");
      return;
    }
    final response = await dio.get(
        "https://api.weatherapi.com/v1/forecast.json?q=${_position.value!.latitude},${_position.value!.longitude}&days=14&key=$apiKey");
    _weatherData.value = WeatherDataModel.fromJson(response.data);
  }

  getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      Get.snackbar("Location Service Not Found!",
          "The location service is not enabled in the device!");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Location Permission Denied!",
          "The location permissions are permanently denied for the application! Kindly enable them from the app settings!");
      Geolocator.openAppSettings();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position location = await Geolocator.getCurrentPosition();
      _position.value = location;
    }
    return permission;
  }
}
