import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/constants/app_theme.dart';
import 'package:weather_app/screens/bloc/home_bloc.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Position position = await _determinePosition();
  await dotenv.load(fileName: ".env");
  runApp(MyApp(
    lat: position.latitude.toDouble(),
    long: position.longitude.toDouble(),
  ));
}

class MyApp extends StatelessWidget {
  final double lat;
  final double long;
  const MyApp({
    super.key,
    required this.lat,
    required this.long,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => HomeBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            themeMode: ThemeMode.system,
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            home: HomeScreen(
              lat: lat,
              long: long,
            ),
          ),
        );
      },
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}
