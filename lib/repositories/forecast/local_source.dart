import 'package:evaranshark_weathercast/models/forecast_model.dart';
import 'package:evaranshark_weathercast/models/weather.dart';
import 'package:evaranshark_weathercast/repositories/forecast/source.dart';
import 'package:hive/hive.dart';

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<Weather?> fetchWeather(double lon, double lat) async {
    var box = await Hive.openBox<Weather>("forecast");
    Weather? value;
    if (box.isNotEmpty) {
      value = box.getAt(0);
    }
    await box.close();
    return value;
  }

  @override
  storeWeather(Weather data) async {
    var box = await Hive.openBox<Weather>("forecast");
    await box.clear();
    await box.add(data);
    await box.close();
  }

  @override
  Future<ForecastModel?> fetchForecast(double lon, double lat) {
    // TODO: implement fetchForecast
    throw UnimplementedError();
  }
}
