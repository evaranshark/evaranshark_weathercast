import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'weather.dart';

part 'forecast_model.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class ForecastModel {
  @HiveField(0)
  @JsonKey(name: 'list')
  final List<Weather> items;

  ForecastModel(this.items);

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);
}
