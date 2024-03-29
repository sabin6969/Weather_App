import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/exceptions/app_exceptions.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/weather_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherRepository _weatherRepository = WeatherRepository();
  HomeBloc() : super(HomeInitial()) {
    on<HomeLoadWeatherDataWithCity>(
      (event, emit) async {
        try {
          emit(HomeLoading());
          Weather weatherData = await _weatherRepository
              .getWeatherDataWithCityName(city: event.city);
          emit(HomeLoaded(weatherData: weatherData));
        } on ServerRequestTimeoutException catch (e) {
          emit(HomeError(errorMessage: e.message));
        } on NotFoundException catch (e) {
          emit(HomeError(errorMessage: e.message));
        } on SocketException {
          emit(HomeError(errorMessage: "No internet"));
        } on HandshakeException {
          emit(
            HomeError(
                errorMessage:
                    "Couldnot establish secure connection with server"),
          );
        } catch (e) {
          emit(HomeError(errorMessage: e.toString()));
        }
      },
    );
    on<HomeLoadWeatherDataWithLatLon>(
      (event, emit) async {
        try {
          emit(HomeLoading());
          Weather weatherData =
              await _weatherRepository.getWeatherDataWithLatLon(
            lat: event.lat,
            lon: event.lon,
          );
          emit(HomeLoaded(weatherData: weatherData));
        } on ServerRequestTimeoutException catch (e) {
          emit(HomeError(errorMessage: e.message));
        } on NotFoundException catch (e) {
          emit(HomeError(errorMessage: e.message));
        } on SocketException {
          emit(HomeError(errorMessage: "No internet"));
        } on HandshakeException {
          emit(
            HomeError(
                errorMessage:
                    "Couldnot establish secure connection with server"),
          );
        } catch (e) {
          emit(
            HomeError(errorMessage: "An unknown error occured try again"),
          );
        }
      },
    );
  }
}
