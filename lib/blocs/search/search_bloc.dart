import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  //
  TrafficService trafficService;

  SearchBloc({
    required this.trafficService,
  }) : super(const SearchState()) {
    // EVENTOS
    on<OnActivateManualMarketEvent>((event, emit) => emit(state.copyWith(displayManualMarker: true)));
    on<OnDeactivateManualMarketEvent>((event, emit) => emit(state.copyWith(displayManualMarker: false)));
  }

  Future<RouteDestination> getCoordsStartToEnd(LatLng start, LatLng end) async {
    //
    final trafficResp = await trafficService.getCoordStartToEnd(start, end);

    final geometry = trafficResp.routes?[0]?.geometry;
    final distance = trafficResp.routes?[0]?.distance;
    final duration = trafficResp.routes?[0]?.duration;

    //*decodificar
    final points = decodePolyline(geometry!, accuracyExponent: 6);
    final latLngList = points.map((coord) => LatLng(coord[0].toDouble(), coord[1].toDouble())).toList();

    return RouteDestination(
      points: latLngList,
      duration: duration!,
      distance: distance!,
    );
  }
}
