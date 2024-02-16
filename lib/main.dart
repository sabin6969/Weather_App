import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/constants/app_theme.dart';
import 'package:weather_app/screens/bloc/home_bloc.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            home: const HomeScreen(),
          ),
        );
      },
    );
  }
}
