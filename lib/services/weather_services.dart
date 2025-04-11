import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class WeatherServices {
  // Fetch weather data for a city
  getWeather(String city) async {
    var response = await http.get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=a463d68284691b03bcb490d0b5e38e6c&unit=metric'),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['base']);
      print(data['name']);
      return WeatherModel.fromJson(data);
    }
  }

  // Fetch current city or district based on coordinates
  getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    // Convert the location to a placemark (City, District, Country)
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    // Extract the district (Administrative Area Level 2) and return it
    String? district = placemarks[0].subAdministrativeArea; // District is generally stored here
    print(district.toString());

    // If no district is found, fall back to city
    return district ?? placemarks[0].locality ?? "";
  }
}
