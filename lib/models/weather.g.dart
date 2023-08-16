// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 0;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      (fields[1] as List).cast<WeatherData>(),
      fields[2] as DateTime,
      fields[0] as MainData,
      fields[3] as String?,
      fields[4] as WindData,
    )..forecast = fields[5] as ForecastModel?;
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.mainData)
      ..writeByte(1)
      ..write(obj.weatherData)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.locationName)
      ..writeByte(4)
      ..write(obj.wind)
      ..writeByte(5)
      ..write(obj.forecast);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeatherDataAdapter extends TypeAdapter<WeatherData> {
  @override
  final int typeId = 1;

  @override
  WeatherData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherData(
      fields[0] as String,
      fields[1] as String,
      fields[2] as WeatherConditions,
      fields[3] as IconId,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.main)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.weatherCondition)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MainDataAdapter extends TypeAdapter<MainData> {
  @override
  final int typeId = 2;

  @override
  MainData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainData(
      fields[0] as double,
      fields[1] as int,
      fields[2] as double,
      fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MainData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.temp)
      ..writeByte(1)
      ..write(obj.humidity)
      ..writeByte(2)
      ..write(obj.tempMin)
      ..writeByte(3)
      ..write(obj.tempMax);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WindDataAdapter extends TypeAdapter<WindData> {
  @override
  final int typeId = 3;

  @override
  WindData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WindData(
      fields[0] as double,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WindData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.speed)
      ..writeByte(1)
      ..write(obj.direction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WindDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeatherConditionsAdapter extends TypeAdapter<WeatherConditions> {
  @override
  final int typeId = 4;

  @override
  WeatherConditions read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WeatherConditions.thunder;
      case 1:
        return WeatherConditions.slightRain;
      case 2:
        return WeatherConditions.sunnyRain;
      case 3:
        return WeatherConditions.sun;
      case 4:
        return WeatherConditions.snow;
      case 5:
        return WeatherConditions.rain;
      default:
        return WeatherConditions.thunder;
    }
  }

  @override
  void write(BinaryWriter writer, WeatherConditions obj) {
    switch (obj) {
      case WeatherConditions.thunder:
        writer.writeByte(0);
        break;
      case WeatherConditions.slightRain:
        writer.writeByte(1);
        break;
      case WeatherConditions.sunnyRain:
        writer.writeByte(2);
        break;
      case WeatherConditions.sun:
        writer.writeByte(3);
        break;
      case WeatherConditions.snow:
        writer.writeByte(4);
        break;
      case WeatherConditions.rain:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherConditionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IconIdAdapter extends TypeAdapter<IconId> {
  @override
  final int typeId = 7;

  @override
  IconId read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return IconId.clear;
      case 1:
        return IconId.snow;
      case 2:
        return IconId.cloudD;
      case 3:
        return IconId.cloudN;
      case 4:
        return IconId.rain;
      case 5:
        return IconId.thunder;
      default:
        return IconId.clear;
    }
  }

  @override
  void write(BinaryWriter writer, IconId obj) {
    switch (obj) {
      case IconId.clear:
        writer.writeByte(0);
        break;
      case IconId.snow:
        writer.writeByte(1);
        break;
      case IconId.cloudD:
        writer.writeByte(2);
        break;
      case IconId.cloudN:
        writer.writeByte(3);
        break;
      case IconId.rain:
        writer.writeByte(4);
        break;
      case IconId.thunder:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      (json['weather'] as List<dynamic>)
          .map((e) => WeatherData.fromJson(e as Map<String, dynamic>))
          .toList(),
      const EpochDateTimeConverter().fromJson(json['dt'] as int),
      MainData.fromJson(json['main'] as Map<String, dynamic>),
      json['name'] as String?,
      WindData.fromJson(json['wind'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'main': instance.mainData,
      'weather': instance.weatherData,
      'dt': const EpochDateTimeConverter().toJson(instance.dateTime),
      'name': instance.locationName,
      'wind': instance.wind,
    };

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) => WeatherData(
      json['main'] as String,
      json['description'] as String,
      const WeatherConditionsConverter().fromJson(json['id'] as int),
      const IconIdConverter().fromJson(json['icon'] as String),
    );

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'main': instance.main,
      'description': instance.description,
      'id':
          const WeatherConditionsConverter().toJson(instance.weatherCondition),
      'icon': const IconIdConverter().toJson(instance.icon),
    };

MainData _$MainDataFromJson(Map<String, dynamic> json) => MainData(
      (json['temp'] as num).toDouble(),
      json['humidity'] as int,
      (json['temp_min'] as num).toDouble(),
      (json['temp_max'] as num).toDouble(),
    );

Map<String, dynamic> _$MainDataToJson(MainData instance) => <String, dynamic>{
      'temp': instance.temp,
      'humidity': instance.humidity,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
    };

WindData _$WindDataFromJson(Map<String, dynamic> json) => WindData(
      (json['speed'] as num).toDouble(),
      const WindDirectionConverter().fromJson(json['deg'] as int),
    );

Map<String, dynamic> _$WindDataToJson(WindData instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': const WindDirectionConverter().toJson(instance.direction),
    };
