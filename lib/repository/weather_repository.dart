import 'package:weather_app/data/weather_services.dart';

class WeatherRepository {
  WeatherServices weatherServices = WeatherServices();
  Future<dynamic> getWeatherData({required String city}) async {
    return await weatherServices.fetchWeatherData(city);
  }
}
