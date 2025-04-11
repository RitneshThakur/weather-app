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
      // Null check for cityName, fallback to an empty string if null
      cityName: json["name"] ?? "",

      // Null check for temperature, if it's null, fallback to null
      temperature: json["main"] != null && json["main"]['temp'] != null
          ? (json["main"]['temp'] - 273.15)
          : null,

      // Null check for mainCondition, fallback to an empty string if null
      mainCondition: json['weather'] != null && json['weather'][0] != null
          ? json['weather'][0]['main']
          : "",

      // Null check for icon, fallback to an empty string if null
      icon: json['weather'] != null && json['weather'][0] != null
          ? json['weather'][0]['icon']
          : "",

      // Null check for feelsLike, fallback to null if null
      feelsLike: json['main'] != null && json['main']['feels_like'] != null
          ? (json['main']['feels_like'] - 273.15)
          : null,

      // Null check for maxTemp, fallback to null if null
      maxTemp: json['main'] != null && json['main']['temp_max'] != null
          ? (json['main']['temp_max'] - 273.15)
          : null,

      // Null check for minTemp, fallback to null if null
      minTemp: json['main'] != null && json['main']['temp_min'] != null
          ? (json['main']['temp_min'] - 273.15)
          : null,

      // Null check for pressure, fallback to null if null
      pressure: json['main'] != null && json['main']['pressure'] != null
          ? json['main']['pressure']
          : null,

      // Null check for humidity, fallback to null if null
      humidity: json['main'] != null && json['main']['humidity'] != null
          ? json['main']['humidity']
          : null,

      // Null check for timezone, fallback to null if null
      timezone: json['timezone'] != null ? json['timezone'] : null,

      // Null check for sunrise, fallback to null if null
      sunrise: json['sys'] != null && json['sys']['sunrise'] != null
          ? json['sys']['sunrise']
          : null,

      // Null check for sunset, fallback to null if null
      sunset: json['sys'] != null && json['sys']['sunset'] != null
          ? json['sys']['sunset']
          : null,

      // Null check for country, fallback to an empty string if null
      country: json['sys'] != null && json['sys']['country'] != null
          ? json['sys']['country']
          : "",
    );
  }
}
