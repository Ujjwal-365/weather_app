class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double feelsLike;
  final DateTime time;
  Weather(
      {required this.cityName,
      required this.mainCondition,
      required this.temperature,
      required this.feelsLike,
      required this.time
      });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      mainCondition: json['weather'][0]['main'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      time: DateTime.now(),

    );
  }
}
