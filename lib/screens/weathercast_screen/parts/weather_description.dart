import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/forecast_bloc.dart';
import '../bloc/forecast_state.dart';

class WeatherDesc extends StatelessWidget {
  const WeatherDesc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastBloc, ForecastState>(
        builder: (context, forecastState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (forecastState is HasForecastData)
            Text(
              "${forecastState.data.mainData.temp.round()}º",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          if (forecastState is HasForecastData)
            Text(
              toBeginningOfSentenceCase(
                  forecastState.data.weatherData[0].description)!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          const SizedBox(
            height: 8.0,
          ),
          if (forecastState is HasForecastData)
            Text(
              "Макс.: ${forecastState.data.mainData.tempMax.ceil()}º Мин: ${forecastState.data.mainData.tempMin.floor()}º",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
        ],
      );
    });
  }
}
