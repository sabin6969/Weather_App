import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/app_animation_path.dart';
import 'package:weather_app/screens/bloc/home_bloc.dart';
import 'package:weather_app/widgets/display_weather_data.dart';
import 'package:weather_app/widgets/requested_city_not_found.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityNameController = TextEditingController();

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeLoadWeatherData(city: "Pokhara"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              // vertical: 30.h,
            ),
            child: BlocBuilder(
              bloc: homeBloc,
              builder: (context, state) {
                if (state is HomeLoading) {
                  return SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(AppAnimationPath.weatherDataLoading),
                        SizedBox(
                          height: 10.h,
                        ),
                        const CircularProgressIndicator()
                      ],
                    ),
                  );
                } else if (state is HomeLoaded) {
                  return DisplayWeatherData(
                    cityNameController: _cityNameController,
                    state: state,
                  );
                } else if (state is HomeError) {
                  return RequesteCityNotFound(
                    cityNameController: _cityNameController,
                    state: state,
                  );
                } else {
                  return const Center();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
