import 'package:evaranshark_weathercast/models/forecast_model.dart';
import 'package:evaranshark_weathercast/models/weather.dart';

abstract class DataSource {
  Future<Weather?> fetchWeather(double lon, double lat);
  Future<ForecastModel?> fetchForecast(double lon, double lat);
}

abstract class LocalDataSource extends DataSource {
  storeWeather(Weather data);
}
