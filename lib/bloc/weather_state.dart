part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {

}

class WeatherLoading extends WeatherState{

}

class WeatherSuccess extends WeatherState{
  final Weather weather;

  const WeatherSuccess(this.weather);

}

class WeatherFailure extends WeatherState{

}
