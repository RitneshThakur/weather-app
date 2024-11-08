import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class WeatherServices {
  getWeather(String city) async {
    var response = await http.get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=a463d68284691b03bcb490d0b5e38e6c&unit=metric'),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['base']);
      print(data['name']);
      return WeatherModel.fromJson(data);
    }
  }

  getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    //convert the location of the city
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // return the name of city
    String? city = placemarks[0].locality;
    print(city.toString());
    return city ?? "";
  }
}
