import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:evaranshark_weathercast/repositories/forecast/forecast_repo.dart';
import 'package:evaranshark_weathercast/repositories/geolocation_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forecast_event.dart';
import 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final ForecastRepository repository;
  late final GeolocationRepository locationRepo;

  ForecastBloc(this.repository) : super(NoData()) {
    locationRepo = GeolocationRepository();
    locationRepo.positionStream.stream.listen(onPositionRetrieved);
    locationRepo.errorStream.stream.listen(onLocationError);

    on<FetchWeather>(
      (event, emit) async {
        emit(FetchingPosition());
        await locationRepo.fetchPosition();
      },
    );

    on<PositionRetrieved>(
      (event, emit) async {
        final connect = await (Connectivity().checkConnectivity());
        if (connect == ConnectivityResult.none) {
          emit(ForecastError("Отсутствует подключение к интернету"));
        }

        emit(ForecastLoading());

        await Future.delayed(const Duration(seconds: 2));

        try {
          var data = await repository.fetchWeather(
              event.position.lon, event.position.lat);
          if (data != null) {
            emit(HasForecastData(data));
          } else {
            emit(NoData());
          }
        } on Exception catch (e) {
          emit(ForecastError(e.toString()));
        }
      },
    );

    on<LocationExceptionRetrieved>(
      (event, emit) {
        if (event.exception is NoPositionDataException) {
          emit(ForecastError("Сервисы геолокации отключены"));
          emit(NoData());
        } else if (event.exception is LocationPermissionDeniedException) {
          emit(ForecastError("Доступ к местоположению запрещён"));
          emit(NoData());
        } else if (event.exception
            is LocationPermissionDeniedForeverException) {
          emit(PermissionsError(
              "Доступ к местоположению запрещён. Разрешите определение местоположения в настройках"));
          emit(NoData());
        }
      },
    );
  }

  onPositionRetrieved(HivePosition position) {
    add(PositionRetrieved(position));
  }

  onLocationError(LocationException error) {
    add(LocationExceptionRetrieved(error));
  }
}
