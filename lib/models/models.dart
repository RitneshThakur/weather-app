class WeatherModel {
  final String? cityName;
  final double? temperature;
  final String? mainCondition;
  final String? icon;
  final double? minTemp;
  final double? maxTemp;
  final double? feelsLike;
  final int? pressure;
  final int? humidity;
  final int? sunset;
  final int? sunrise;
  final String? country;
  final int? timezone;

  WeatherModel({
    this.cityName,
    this.temperature,
    this.mainCondition,
    this.icon,
    this.country,
    this.feelsLike,
    this.humidity,
    this.maxTemp,
    this.minTemp,
    this.pressure,
    this.sunrise,
    this.sunset,
    this.timezone,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(

      cityName: json["name"],
      temperature: (json["main"]['temp'] - 273.15),
      mainCondition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      feelsLike: (json['main']['feels_like'] - 273.15),
      maxTemp: (json['main']['temp_max'] - 273.15),
      minTemp: (json['main']['temp_min'] - 273.15),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      timezone: json['timezone'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      country: json['sys']['country'],
    );
  }
}
