import 'package:evaranshark_weathercast/models/forecast_model.dart';
import 'package:evaranshark_weathercast/models/weather.dart';
import 'package:evaranshark_weathercast/repositories/forecast/forecast_repo.dart';
import 'package:evaranshark_weathercast/repositories/forecast/local_source.dart';
import 'package:evaranshark_weathercast/repositories/forecast/remote_source.dart';
import 'package:evaranshark_weathercast/repositories/geolocation_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final locator = GetIt.instance;

initServices() async {
  await _initHive();
  locator.registerSingleton<ForecastRepository>(ForecastRepository(
      remote: RemoteDataSource(), local: LocalDataSourceImpl()));
}

_initHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(WeatherAdapter());
  Hive.registerAdapter(MainDataAdapter());
  Hive.registerAdapter(WeatherDataAdapter());
  Hive.registerAdapter(WindDataAdapter());
  Hive.registerAdapter(WeatherConditionsAdapter());
  Hive.registerAdapter(HivePositionAdapter());
  Hive.registerAdapter(ForecastModelAdapter());
  Hive.registerAdapter(IconIdAdapter());
}
