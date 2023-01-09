import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  //
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;

  StreamSubscription<LocationState>? locationSubscription;

  MapBloc({
    required this.locationBloc,
  }) : super(const MapState()) {
    //
    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowingUserMap>(_onStartFollowingUser);
    on<OnStopFollowingUserMap>((event, emit) => emit(state.copyWith(followUser: false)));
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    on<OnToggleShowRoute>((event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));

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
