import 'dart:convert';

import 'package:weather_app/exceptions/app_exceptions.dart';
import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherServices {
  String apiKey = dotenv.env["OPEN_WEATHER_API_KEY"] ?? "noapi";
  Future<Weather> fetchWeatherDataWithCityName(String city) async {
    String endPoint =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey";
    Response response = await get(Uri.parse(endPoint))
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw ServerRequestTimeoutException();
    });
    switch (response.statusCode) {
      case 200:
        String body = response.body;
        var jsonData = jsonDecode(body);
        return Weather.fromJson(jsonData);
      case 401:
        throw UnAuthorizedException();
      case 404:
        throw NotFoundException(
            message: "Weather data of requested city not found");
      case 500:
        throw InternalServerException();
      default:
        throw Exception("Some thing went wrong try again");
    }
  }

  Future<Weather> fetchWeatherDataWithLatLon(
      {required double lon, required double lat}) async {
    String endPoint =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey";
    Response response = await get(Uri.parse(endPoint))
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw ServerRequestTimeoutException();
    });
    switch (response.statusCode) {
      case 200:
        String body = response.body;
        var jsonData = jsonDecode(body);
        return Weather.fromJson(jsonData);
      case 401:
        throw UnAuthorizedException();
      case 404:
        throw NotFoundException(
            message: "Weather data of requested city not found");
      case 500:
        throw InternalServerException();
      default:
        throw Exception("Some thing went wrong try again");
    }
  }
}
