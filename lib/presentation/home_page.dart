import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/components/widgets/weather_item.dart';
import 'package:weather_app/utils/app_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, kToolbarHeight + 16, 40, 1.2),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherSuccess) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.purple),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.purple),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, -1.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFFFAB40)),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "📍 ${state.weather.areaName}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Good Morning",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          Image.asset(AppImages.sunWithCloud),
                          Center(
                            child: Text(
                              "${state.weather.temperature?.celsius?.round()}°C",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherMain!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat("EEEE dd mm:hh").format(state.weather.date!),
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherItem(
                                  image: AppImages.sunrise,
                                  title: "Sunrise",
                                  time: DateFormat("mm:hh").format(state.weather.sunrise!)),
                              WeatherItem(
                                  image: AppImages.sunset,
                                  title: "Sunset",
                                  time: DateFormat("mm:hh").format(state.weather.sunset!)),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Divider(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherItem(
                                  image: AppImages.tempratureMax,
                                  title: "TemMax",
                                  time: "${state.weather.tempMax}°C"),
                              WeatherItem(
                                  image: AppImages.tempratureMin,
                                  title: "TemMin",
                                  time: "7°C"),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state is WeatherLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherFailure) {
              return Center(
                child: Text("Something went wrong!"),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
