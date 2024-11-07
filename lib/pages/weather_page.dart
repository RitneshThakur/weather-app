import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr/models/models.dart';
import 'package:qr/services/weather_services.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherServices=WeatherServices("17e7debf6d23ffad9a2ef51f90782cc8");
  Weather? _weather;
  //fetch the weather
  _fetchWeather() async{
    //get the current city
    String cityName=await _weatherServices.getCurrentCity();
    try{
      final weather= await _weatherServices.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition==null) return "asset/sunny.json";
    switch(mainCondition.toLowerCase()){
      case 'clouds':
        return 'asset/cloud.json';
      case 'thunderstorm':
        return 'asset/thunder.json';
      case 'rain':
        return 'asset/rain.json';
      case 'clear':
        return 'asset/sunny.json';
      default:
        return 'asset/sunny.json';
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetch weathers on startup
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text(_weather?.cityName ?? "loading city name..."),
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              Text('${_weather?.temperature.round()}°C'),
              Text(_weather?.mainCondition?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
