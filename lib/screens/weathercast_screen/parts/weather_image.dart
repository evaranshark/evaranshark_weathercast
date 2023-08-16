import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/weather.dart';
import '../../../services/constants.dart';
import '../../../widgets/gpn_bubble.dart';
import '../bloc/forecast_bloc.dart';
import '../bloc/forecast_state.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage({super.key});

  String resolveAsset(WeatherConditions condition) {
    return switch (condition) {
      WeatherConditions.sun => Assets.sun,
      WeatherConditions.slightRain => Assets.slightRain,
      WeatherConditions.sunnyRain => Assets.sunnyRain,
      WeatherConditions.rain => Assets.rain,
      WeatherConditions.thunder => Assets.thunder,
      WeatherConditions.snow => Assets.snow,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastBloc, ForecastState>(
        builder: (context, forecastState) {
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 180,
          maxHeight: 180,
        ),
        child: (forecastState is HasForecastData)
            ? Image.asset(
                resolveAsset(forecastState.data.weather.weatherCondition),
                fit: BoxFit.fill,
              )
            : const Center(
                child: GpnBubble(),
              ),
      );
    });
  }
}
