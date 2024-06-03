import 'dart:convert';
import 'dart:developer' as developer;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  static const BASE_URL ='http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;
  bool validCity= true;
  WeatherServices(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    // cityName='Roorkee';

    final url = Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric');
    // developer.debugger(when: true , message: 'Constructed URL: $url');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode == 404){
      throw Exception('Failed to find city }');
    }
    else {
        throw Exception('Failed to load weather data ${response.statusCode} }');
    }
  }

  Future<String> getCurrentCity() async {
   LocationPermission permission = await Geolocator.checkPermission();
   if(permission == LocationPermission.denied) {
     permission = await Geolocator.requestPermission();
   }
   Position position = await Geolocator.getCurrentPosition(
     desiredAccuracy: LocationAccuracy.best
   );
   List<Placemark> placemarks= await placemarkFromCoordinates(position.latitude, position.longitude);
   String? city = placemarks[0].locality;
   return city ?? "";

  }
}