import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/blocs.dart';

class MapView extends StatelessWidget {
  //
  final LatLng initialLocation;
  final Set<Polyline> polylines;

  const MapView({
    super.key,
    required this.initialLocation,
    required this.polylines,
  });

  @override
  Widget build(BuildContext context) {
    //
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition iCP = CameraPosition(
      target: initialLocation,
      zoom: 14.4746,
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (pointerMoveEvent) => mapBloc.add(OnStopFollowingUserMap()),
        child: GoogleMap(
          initialCameraPosition: iCP,
          padding: const EdgeInsets.all(16),
          compassEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          polylines: polylines,
          onMapCreated: (controller) => mapBloc.add(OnMapInitializedEvent(controller)),
          //TODO MARKERS
          //TODO cuando se mueve el mapa
        ),
      ),
    );
  }
}
