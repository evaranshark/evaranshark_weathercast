import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:evaranshark_weathercast/models/forecast_model.dart';

import '../../models/weather.dart';
import 'source.dart';

class ForecastRepository {
  DataSource remote;
  LocalDataSource local;

  ForecastRepository({required this.remote, required this.local});

  Future<Weather?> fetchWeather(double lon, double lat) async {
    Weather? data;
    ForecastModel? forecastData;
    final connect = await (Connectivity().checkConnectivity());
    if (connect != ConnectivityResult.none) {
      try {
        data = await remote.fetchWeather(lon, lat);
        forecastData = await remote.fetchForecast(lon, lat);
      } catch (e) {
        rethrow;
      }
    }
    if (data != null) {
      data.forecast = forecastData;
      await local.storeWeather(data);
    }
    data ??= await local.fetchWeather(lon, lat);
    return data;
  }
}
