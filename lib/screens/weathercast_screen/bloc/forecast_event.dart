import 'package:evaranshark_weathercast/repositories/geolocation_repo.dart';

sealed class ForecastEvent {}

final class ClearEvent extends ForecastEvent {}

final class FetchWeather extends ForecastEvent {}

final class PositionRetrieved extends ForecastEvent {
  final HivePosition position;

  PositionRetrieved(this.position);
}

final class LocationExceptionRetrieved extends ForecastEvent {
  final LocationException exception;

  LocationExceptionRetrieved(this.exception);
}
