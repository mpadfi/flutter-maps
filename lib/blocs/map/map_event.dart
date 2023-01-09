part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

// Evento de inicialización del mapa
class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapInitializedEvent(this.controller);
}

// Evento para dejar de seguir al usuario o seguir
class OnStopFollowingUserMap extends MapEvent {}

class OnStartFollowingUserMap extends MapEvent {}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> userLocations;
  const UpdateUserPolylineEvent(this.userLocations);
}

class OnToggleShowRoute extends MapEvent {}
