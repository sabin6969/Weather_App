import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/screens/bloc/home_bloc.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 30.h,
          ),
          child: BlocBuilder(
            bloc: homeBloc,
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeLoaded) {
                print(state.weatherData.sys!.sunrise);
                return Column(
                  children: [
                    TextFormField(
                      controller: _cityNameController,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {
                            context.read<HomeBloc>().add(
                                  HomeLoadWeatherData(
                                    city: _cityNameController.text,
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
                    Text(
                      state.weatherData.name ?? "",
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      state.weatherData.main!.feelsLike.toString(),
                      style: TextStyle(
                        fontSize: 45.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Max temp ${state.weatherData.main!.tempMax}"),
                        Text("Min temp ${state.weatherData.main!.tempMin}"),
                        Text("Min temp ${state.weatherData.sys!.sunrise}"),
                        Text("Min temp ${state.weatherData.sys!.sunset}"),
                      ],
                    ),
                    Text(
                      state.weatherData.weather!.first.description!
                          .toUpperCase(),
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                  ],
                );
              } else if (state is HomeError) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return const Center(
                  child: Text("Khai k vayo"),
                );
              }
            },
          )),
    );
  }
}
