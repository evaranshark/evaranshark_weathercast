import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

part 'geolocation_repo.g.dart';

class GeolocationRepository {
  final serviceStatusStream = Geolocator.getServiceStatusStream();

  final StreamController<HivePosition> positionStream =
      StreamController.broadcast();
  final StreamController<LocationException> errorStream =
      StreamController.broadcast();

  Future<void> fetchPosition() async {
    try {
      await _checkPermissions();
    } on LocationException catch (e) {
      errorStream.sink.add(e);
      return;
    }

    if (await Geolocator.isLocationServiceEnabled()) {
      var position = await Geolocator.getCurrentPosition();
      var hivePosition = HivePosition(position.latitude, position.longitude);
      positionStream.sink.add(hivePosition);
      await _storePosition(position);
    } else {
      var position = await _getStoredPosition();
      if (position != null) {
        positionStream.sink.add(position);
      } else {
        errorStream.sink.add(NoPositionDataException());
      }
    }
  }

  Future<HivePosition?> _getStoredPosition() async {
    final box = await Hive.openBox<HivePosition>("geolocation");
    HivePosition? position;
    if (box.isNotEmpty) {
      position = box.getAt(0);
    }
    await box.close();
    return position;
  }

  _storePosition(Position position) async {
    final box = await Hive.openBox<HivePosition>("geolocation");
    await box.clear();
    await box.add(HivePosition(position.latitude, position.longitude));
    await box.close();
  }

  _checkPermissions() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionDeniedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedForeverException();
    }
  }
}

sealed class LocationException implements Exception {}

class LocationPermissionDeniedException implements LocationException {}

class LocationPermissionDeniedForeverException implements LocationException {}

class NoPositionDataException implements LocationException {}

@HiveType(typeId: 5)
class HivePosition {
  @HiveField(0)
  final double lat;

  @HiveField(1)
  final double lon;

  HivePosition(this.lat, this.lon);
}
