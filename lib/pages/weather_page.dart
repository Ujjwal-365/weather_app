import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {

  final location;
  const WeatherPage({super.key, required this.location});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherServices('473bbd0e505c72f05f1d89576972b116');
  Weather? _weather;
  String? cityName;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'Clear':
        return 'assets/sunny';
      default:
        return 'assets/sunny.json';
    }
  }

  _fetchWeather() async {
    // cityName = await _weatherService.getCurrentCity();
    cityName= widget.location;
    // print(cityName);
    try {
      final weather = await _weatherService.getWeather(cityName!);
      setState(() {
        _weather = weather  ;
      });
    } catch (e) {
      // throw Exception('Error fetching weather: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Can't find weather of this location. Please enter the nearest town or city."),
        duration: Duration(seconds: 8),
        backgroundColor: Colors.transparent,),
      );
      Navigator.of(context).pop();

    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: (_weather != null)
            ? Stack(
                children: [
                  Lottie.asset('assets/Animation - 1715360854855.json',
                      alignment: Alignment.topCenter,
                      height: double.infinity,
                      fit: BoxFit.fill),


                  Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Padding(
                      padding: EdgeInsets.all(10),
                      child:Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${_weather?.cityName.toString()}',
                                style:const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 50,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 100.0,
                                      color: Colors.white,

                                    )
                                  ]
                                ),),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                                  child: Icon(Icons.location_on,color: Colors.white,

                                  size:30,

                                  ),
                                ),
                              ],
                            ),

                            Text('${_weather?.temperature.round()}°C  /  ${_weather?.mainCondition}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),),
                            SizedBox(height: 20,),
                            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

                          ],
                        ),
                      ),

                    ),
                  )
                ],
              )
            : Stack(
                children: [
                  SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Lottie.asset(
                          'assets/Animation - 1715360854855.json',
                          repeat: true,
                          fit: BoxFit.cover)),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/earth-rotate.json',
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
