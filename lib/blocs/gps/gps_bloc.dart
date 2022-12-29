import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  //
  StreamSubscription? gpsServiceSubscription;

  GpsBloc() : super(const GpsState(isGpsEnabled: false, isGpsPermissionsGranted: false)) {
    //
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
          isGpsEnabled: event.isGpsEnabled,
          isGpsPermissionsGranted: event.isGpsPermissionsGranted,
        )));

    _init();
  }

  // INICIAR COMPROBACIÓN GPS-STATUS Y PERMISOS
  Future<void> _init() async {
    // final isEnabled = await _checkGpsStatus();
    // final isGranted = await _isPermissionGranted();

    // HACEMOS LOS 2 FUTURES DE MANERA SIMULTANEA
    final gpsStatusAndPermission = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);

    // emitimos un evento
    add(GpsAndPermissionEvent(
      isGpsEnabled: gpsStatusAndPermission[0],
      isGpsPermissionsGranted: gpsStatusAndPermission[1],
    ));
  }

  Future<bool> _checkGpsStatus() async {
    // Revisamos si está activo el GPS
    final isEnable = await Geolocator.isLocationServiceEnabled();

    // LISTENER DE SEGUIMIENTO DEL ESTADO DEL GPS:  gps-on/gps-off
    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event) {
      final isGpsEnabled = (event.index == 1) ? true : false;
      // emitimos un evento
      add(GpsAndPermissionEvent(
        isGpsEnabled: isGpsEnabled,
        isGpsPermissionsGranted: state.isGpsPermissionsGranted,
      ));
    });
    return isEnable;
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  // SOLICITAR PERMISOS GPS
  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionsGranted: true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionsGranted: false));
        openAppSettings();
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
