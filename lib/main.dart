import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/data/location.dart';
import 'package:weather_app/presentation/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: GoogleFonts
              .poppins()
              .fontFamily
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: GetLocation().determinePosition(),
        builder: (context, snap){
          if(snap.hasData){
            return BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc()..add(FetchWeather(snap.data as Position)),
              child: HomePage(),
            );
          }else{
            Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}


