import '../../../models/weather.dart';

sealed class ForecastState {}

final class NoData extends ForecastState {}

final class ForecastError extends ForecastState {
  final String message;

  ForecastError(this.message);
}

final class FetchingPosition extends ForecastState {}

final class PermissionsError extends ForecastError {
  PermissionsError(super.message);
}

final class ForecastLoading extends ForecastState {}

final class HasForecastData extends ForecastState {
  final Weather data;

  HasForecastData(this.data);
}
