import 'dart:async';

import 'package:dio/dio.dart';
import 'package:evaranshark_weathercast/app_config.dart';
import 'package:evaranshark_weathercast/models/forecast_model.dart';
import 'package:evaranshark_weathercast/models/weather.dart';
import 'package:evaranshark_weathercast/repositories/forecast/source.dart';

final class RemoteDataSource implements DataSource {
  @override
  Future<Weather?> fetchWeather(double lon, double lat) {
    final uri = Uri(
        scheme: "https",
        host: "api.openweathermap.org",
        path: "data/2.5/weather",
        queryParameters: {
          'lat': lat.toStringAsFixed(2),
          'lon': lon.toStringAsFixed(2),
          'units': 'metric',
          'appId': FORECAST_API_KEY,
          'lang': 'ru',
        });

    return Dio()
        .getUri(uri)
        .timeout(
          const Duration(seconds: 3),
          onTimeout: () => throw TimeoutException(null),
        )
        .onError<Exception>((error, stackTrace) => throw error)
        .then((value) => Weather.fromJson(value.data));
  }

  @override
  Future<ForecastModel?> fetchForecast(double lon, double lat) {
    final uri = Uri(
        scheme: "https",
        host: "api.openweathermap.org",
        path: "data/2.5/forecast",
        queryParameters: {
          'lat': lat.toStringAsFixed(2),
          'lon': lon.toStringAsFixed(2),
          'units': 'metric',
          'appId': FORECAST_API_KEY,
          'lang': 'ru',
          'cnt': '8',
        });

    return Dio()
        .getUri(uri)
        .timeout(
          const Duration(seconds: 3),
          onTimeout: () => throw TimeoutException(null),
        )
        .onError<Exception>((error, stackTrace) => throw error)
        .then((value) => ForecastModel.fromJson(value.data));
  }
}
