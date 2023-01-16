import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  //
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationSubscription;

  MapBloc({
    required this.locationBloc,
  }) : super(const MapState()) {
    //* EVENTOS
    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowingUserMap>(_onStartFollowingUser);
    on<OnStopFollowingUserMap>((event, emit) => emit(state.copyWith(followUser: false)));
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    on<OnToggleShowRoute>((event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));
    on<DisplayPolylineEvent>((event, emit) => emit(state.copyWith(polylines: event.polylines, markers: event.markers)));

    // MOVER EL MAPA SIGUIENDO LA LOCALIZACIÓN DEL LOCATIONBLOC.LASTKNOWNLOCATION
    locationSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation != null) {
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }

      if (!state.isFollowingUser) return; // si no estamos siguiendo al usuario... return
      if (locationState.lastKnownLocation == null) return; // si no tenemos última localización...return
      moveCamera(locationState.lastKnownLocation!);
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    // asignamos al mapController el controller del evento
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser(OnStartFollowingUserMap event, Emitter<MapState> emit) {
    emit(state.copyWith(followUser: true));
    if (locationBloc.state.lastKnownLocation == null) return;
    // MOVEMOS LA CÁMARA INMEDIATAMENTE A LA ÚLTIMA LOCALIZACIÓN AL PULSAR SEGUIR USUARIO.
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void _onPolylineNewPoint(UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations,
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  Future drawRoutePolyline(RouteDestination destination) async {
    //
    //* CREAMOS LA POLYLINE
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 4,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100; // kms = kms / 100

    int tripDuration = (destination.duration ~/ 60).toInt();

    //* custom marker
    // final startMarkerIcon = await getAssetImageMarker();
    // final endMarkerIcon = await getNetworkImageMarker();

    final startMarkerIcon = await getStartCustomMarker(tripDuration, 'Mi ubicación');
    final endMarkerIcon = await getEndCustomMarker(kms.toInt(), destination.endPlace.text);

    //* MARCADOR INICIO RUTA
    final startMarker = Marker(
      markerId: const MarkerId('start'),
      anchor: const Offset(0, 1),
      position: destination.points.first,
      icon: startMarkerIcon,
      // infoWindow: InfoWindow(
      //   title: 'Inicio',
      //   snippet: 'Distancia: $kms, duración: $tripDuration',
      // ),
    );

    //* MARCADOR FIN RUTA
    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: endMarkerIcon,
      // anchor: const Offset(0, 0),
      // infoWindow: InfoWindow(
      //   title: 'Fin',
      //   snippet: destination.endPlace.placeName,
      // ),
    );

    //* añadimos la polyline al mapa de polylines
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRoute; // sobrescribimos la polyline con id 'route'

    //* añadimos los marcadores al mapa de markers
    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker; // sobrescribimos el marker con id 'start'
    currentMarkers['end'] = endMarker;

    //* evento que crea un nuevo estado con la nueva polyline
    add(DisplayPolylineEvent(currentPolylines, currentMarkers));

    // await Future.delayed(const Duration(milliseconds: 300));
    // mostrar el infowindow automaticamente del marcador start
    // _mapController?.showMarkerInfoWindow(const MarkerId('start'));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationSubscription?.cancel();
    return super.close();
  }
}
