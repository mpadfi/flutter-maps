part of 'gps_bloc.dart';

class GpsState extends Equatable {
  //
  final bool isGpsEnabled;
  final bool isGpsPermissionsGranted;

  // GETTER QUE DEVUELVE ESTADO GPS Y PERMISO CONCEDIDO
  bool get isAllGranted => isGpsEnabled && isGpsPermissionsGranted;

  const GpsState({
    required this.isGpsEnabled,
    required this.isGpsPermissionsGranted,
  });

  GpsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionsGranted,
  }) =>
      GpsState(
        isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
        isGpsPermissionsGranted: isGpsPermissionsGranted ?? this.isGpsPermissionsGranted,
      );

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionsGranted];

  @override
  String toString() => '{ isGpsEnabled: $isGpsEnabled, gpsPermissions: $isGpsPermissionsGranted }';
}
