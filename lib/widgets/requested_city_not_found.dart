import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/app_animation_path.dart';
import 'package:weather_app/screens/bloc/home_bloc.dart';

class RequesteCityNotFound extends StatelessWidget {
  final TextEditingController cityNameController;
  final HomeError state;

  const RequesteCityNotFound(
      {super.key, required this.cityNameController, required this.state});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          TextFormField(
            controller: cityNameController,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () {
                  context.read<HomeBloc>().add(
                        HomeLoadWeatherData(
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
          Lottie.asset(AppAnimationPath.weatherDataOfRequestedCityNotFound),
          Text(state.errorMessage),
        ],
      ),
    );
  }
}
