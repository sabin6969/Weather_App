part of 'home_bloc.dart';

sealed class HomeEvent {}

final class HomeLoadWeatherDataWithCity extends HomeEvent {
  final String city;
  HomeLoadWeatherDataWithCity({required this.city});
}

final class HomeLoadWeatherDataWithLatLon extends HomeEvent {
  final double lat;
  final double lon;
  HomeLoadWeatherDataWithLatLon({required this.lat, required this.lon});
}
