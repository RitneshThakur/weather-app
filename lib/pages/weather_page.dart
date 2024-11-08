import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr/constants/custom_text_style.dart';
import 'package:qr/models/models.dart';
import 'package:qr/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherModel? weatherModel;
  final weatherService = WeatherServices();
  String cityName = "";
  String formattedDate =
      DateFormat('EEEE, MMMM d, yyyy, h:mm a').format(DateTime.now());

  fetchCityAndWeather() async {
    var cityName = await weatherService.getCurrentCity();
    setState(() {
      cityName = cityName;
    });
    WeatherModel fetchedWeather = await weatherService.getWeather(cityName);
    setState(() {
      weatherModel = fetchedWeather;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCityAndWeather();
  }

  @override
  Widget build(BuildContext context) {
    if (weatherModel == null) {
      return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('asset/pedro.gif'),

            ),

          ),
        ),
      );
    }

    DateTime sunriseDateTime = DateTime.fromMillisecondsSinceEpoch(
        (weatherModel!.sunrise! + weatherModel!.timezone!) * 1000);
    DateTime sunsetDateTime = DateTime.fromMillisecondsSinceEpoch(
        (weatherModel!.sunset! + weatherModel!.timezone!) * 1000);

    String formattedSunrise = DateFormat('h:mm a').format(sunriseDateTime);
    String formattedSunset = DateFormat('h:mm a').format(sunsetDateTime);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://www.maketecheasier.com/assets/uploads/2021/11/Featured-Image-Live-Weather-Wallpapers-Android.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            ListTile(
              leading: Icon(
                Icons.location_on,
                size: 25,
                color: Colors.white,
              ),
              title: Text(
                weatherModel!.cityName!,
                style: customTextStyle(fontSize: 24, color: Colors.white54),
              ),
              subtitle: Text(
                weatherModel!.country!,
                style: customTextStyle(fontSize: 20, color: Colors.white54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 12, top: 300),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        formattedDate,
                        style: customTextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${weatherModel!.temperature!.toStringAsFixed(2)}°C",
                        style: customTextStyle(fontSize: 60),
                      ),
                      SizedBox(height: 20),
                      Text(
                        weatherModel!.mainCondition!,
                        style: customTextStyle(fontSize: 40),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "min-temp:${weatherModel!.minTemp?.toStringAsFixed(2)}°C",
                            style: customTextStyle(fontSize: 20),
                          ),
                          Text(
                            "max-temp:${weatherModel!.maxTemp?.toStringAsFixed(2)}°C",
                            style: customTextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "feels-Like:${weatherModel!.feelsLike?.toStringAsFixed(2)}°C",
                        style: customTextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: Icon(
                                CupertinoIcons.thermometer,
                                color: Colors.white,
                                size: 30,
                                weight: 1,
                              ),
                              title: Text(
                                "Pressure:",
                                style: customTextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                '${weatherModel!.pressure} hPa',
                                style: customTextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              leading: Icon(
                                CupertinoIcons.cloud_rain,
                                color: Colors.white,
                                size: 30,
                                weight: 1,
                              ),
                              title: Text(
                                "Humidity",
                                style: customTextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                '${weatherModel!.humidity}%',
                                style: customTextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          /*Text("Humidity:\n${weatherModel!.humidity}%"),*/
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Sunrise: $formattedSunrise",
                            style: customTextStyle(fontSize: 20),
                          ),
                          Text(
                            "Sunset: $formattedSunset",
                            style: customTextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
