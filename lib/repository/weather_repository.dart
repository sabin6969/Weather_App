import 'package:weather_app/data/weather_services.dart';

class WeatherRepository {
  WeatherServices weatherServices = WeatherServices();
  Future<dynamic> getWeatherDataWithCityName({required String city}) async {
    return await weatherServices.fetchWeatherDataWithCityName(city);
  }

  Future<dynamic> getWeatherDataWithLatLon(
      {required double lat, required double lon}) async {
    return await weatherServices.fetchWeatherDataWithLatLon(lat: lat, lon: lon);
  }
}
