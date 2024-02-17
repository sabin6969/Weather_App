import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/constants/app_images_path.dart';
import 'package:weather_app/helper/capitalize_first.dart';
import 'package:weather_app/helper/temperature_helper.dart';
import 'package:weather_app/helper/timestamp_formater.dart';
import 'package:weather_app/screens/bloc/home_bloc.dart';

class DisplayWeatherData extends StatelessWidget {
  final TextEditingController cityNameController;
  final HomeLoaded state;

  const DisplayWeatherData({
    super.key,
    required this.cityNameController,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: cityNameController,
          onFieldSubmitted: (value) {
            context.read<HomeBloc>().add(
                  HomeLoadWeatherDataWithCity(
                    city: cityNameController.text,
                  ),
                );
          },
          decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: () {
                context.read<HomeBloc>().add(
                      HomeLoadWeatherDataWithCity(
                        city: cityNameController.text,
                      ),
                    );
              },
              icon: Icon(
                Icons.search,
                color: Theme.of(context).iconTheme.color,
                size: Theme.of(context).iconTheme.size,
              ),
            ),
            hintText: "Search your city",
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          state.weatherData.name ?? "",
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          "${TemperatureHelper.kelvinToCelsius(state.weatherData.main!.feelsLike!)}°C",
          style: TextStyle(
            fontSize: 40.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          CapitalizeFirst.capitalize(
              state.weatherData.weather!.first.description!),
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  AppImagesPath.minTempImagePath,
                  height: 60.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  TemperatureHelper.kelvinToCelsius(
                    state.weatherData.main!.tempMin!,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Image.asset(
                  AppImagesPath.maxTempImagePath,
                  height: 60.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  TemperatureHelper.kelvinToCelsius(
                    state.weatherData.main!.tempMax!,
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  AppImagesPath.sunRiseImagePath,
                  height: 60.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  DateTimeHelper.formatTimestamp(
                    state.weatherData.sys!.sunrise!,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Image.asset(
                  AppImagesPath.sunSetImagePath,
                  height: 60.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  DateTimeHelper.formatTimestamp(
                      state.weatherData.sys!.sunset!),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
