part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final Weather weatherData;

  HomeLoaded({required this.weatherData});
}

final class HomeError extends HomeState {
  final String errorMessage;

  HomeError({required this.errorMessage});
}
