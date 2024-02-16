part of 'home_bloc.dart';

sealed class HomeEvent {}

final class HomeLoadWeatherData extends HomeEvent {
  final String city;
  HomeLoadWeatherData({required this.city});
}
