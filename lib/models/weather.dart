import 'package:evaranshark_weathercast/models/forecast_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Weather {
  @HiveField(0)
  @JsonKey(name: 'main')
  final MainData mainData;

  @HiveField(1)
  @JsonKey(name: 'weather')
  final List<WeatherData> weatherData;

  WeatherData get weather => weatherData[0];

  @HiveField(2)
  @JsonKey(name: "dt")
  @EpochDateTimeConverter()
  final DateTime dateTime;

  @HiveField(3)
  @JsonKey(name: 'name')
  final String? locationName;

  @HiveField(4)
  @JsonKey(name: 'wind')
  WindData wind;

  @HiveField(5)
  @JsonKey(includeFromJson: false, includeToJson: false)
  ForecastModel? forecast;

  Weather(
    this.weatherData,
    this.dateTime,
    this.mainData,
    this.locationName,
    this.wind,
  );

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@HiveType(typeId: 4)
enum WeatherConditions {
  @HiveField(0)
  thunder,
  @HiveField(1)
  slightRain,
  @HiveField(2)
  sunnyRain,
  @HiveField(3)
  sun,
  @HiveField(4)
  snow,
  @HiveField(5)
  rain,
}

class WeatherConditionsConverter
    implements JsonConverter<WeatherConditions, int> {
  const WeatherConditionsConverter();

  @override
  WeatherConditions fromJson(int json) {
    return switch (json) {
      >= 200 && < 300 => WeatherConditions.thunder,
      300 || 301 || 310 || 311 || 520 => WeatherConditions.slightRain,
      >= 500 && < 520 => WeatherConditions.sunnyRain,
      (> 300 || > 520) && < 600 => WeatherConditions.rain,
      >= 600 && < 700 => WeatherConditions.snow,
      _ => WeatherConditions.sun,
    };
  }

  @override
  int toJson(WeatherConditions object) {
    return 800;
  }
}

@HiveType(typeId: 1)
@JsonSerializable()
class WeatherData {
  @HiveField(0)
  final String main;
  @HiveField(1)
  final String description;

  @HiveField(2)
  @JsonKey(name: 'id')
  @WeatherConditionsConverter()
  final WeatherConditions weatherCondition;

  @HiveField(3)
  @JsonKey(name: 'icon')
  @IconIdConverter()
  final IconId icon;

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);

  WeatherData(this.main, this.description, this.weatherCondition, this.icon);

  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class MainData {
  @HiveField(0)
  final double temp;

  @HiveField(1)
  final int humidity;

  @HiveField(2)
  @JsonKey(name: 'temp_min')
  final double tempMin;

  @HiveField(3)
  @JsonKey(name: 'temp_max')
  final double tempMax;

  String get humidityDesc => _resolveHumidity();

  MainData(this.temp, this.humidity, this.tempMin, this.tempMax);

  factory MainData.fromJson(Map<String, dynamic> json) =>
      _$MainDataFromJson(json);

  Map<String, dynamic> toJson() => _$MainDataToJson(this);

  String _resolveHumidity() {
    return switch (humidity) {
      < 20 => "Очень низкая",
      < 30 => "Низкая",
      < 70 => "Средняя",
      < 80 => "Высокая",
      _ => "Очень высокая",
    };
  }
}

class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) =>
      DateTime.fromMillisecondsSinceEpoch(json * 1000, isUtc: true);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}

@HiveType(typeId: 3)
@JsonSerializable()
class WindData {
  @HiveField(0)
  final double speed;

  @HiveField(1)
  @JsonKey(name: 'deg')
  @WindDirectionConverter()
  final String direction;

  WindData(this.speed, this.direction);

  factory WindData.fromJson(Map<String, dynamic> json) =>
      _$WindDataFromJson(json);

  Map<String, dynamic> toJson() => _$WindDataToJson(this);
}

class WindDirectionConverter implements JsonConverter<String, int> {
  const WindDirectionConverter();

  @override
  String fromJson(int json) {
    return switch (json) {
      <= 22 || > 337 => "северный",
      > 22 && <= 67 => "северо-восточный",
      > 67 && <= 112 => "восточный",
      > 112 && <= 157 => "юго-восточный",
      > 157 && <= 202 => "южный",
      > 202 && <= 247 => "юго-западный",
      > 247 && <= 292 => "западный",
      > 292 && <= 337 => "северо-западный",
      _ => "северный",
    };
  }

  @override
  int toJson(String object) {
    return 0;
  }
}

@HiveType(typeId: 7)
enum IconId {
  @HiveField(0)
  clear,
  @HiveField(1)
  snow,
  @HiveField(2)
  cloudD,
  @HiveField(3)
  cloudN,
  @HiveField(4)
  rain,
  @HiveField(5)
  thunder,
}

class IconIdConverter implements JsonConverter<IconId, String> {
  const IconIdConverter();

  @override
  IconId fromJson(String json) => switch (json) {
        "01d" || "01n" => IconId.clear,
        "02d" || "03d" || "04d" => IconId.cloudD,
        "02n" || "03n" || "04n" => IconId.cloudN,
        "13d" || "13n" => IconId.snow,
        "11d" || "11n" => IconId.thunder,
        "09d" || "09n" || "10d" || "10n" => IconId.rain,
        _ => IconId.clear,
      };

  @override
  String toJson(IconId object) => "";
}
