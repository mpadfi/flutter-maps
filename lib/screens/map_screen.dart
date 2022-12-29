import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    super.dispose();
    locationBloc.stopFollowingUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state.lastKnownLocation == null) return const Center(child: Text('Espere por favor'));

          final CameraPosition iCP = CameraPosition(
            target: state.lastKnownLocation!,
            zoom: 14.4746,
          );
          return GoogleMap(
            padding: const EdgeInsets.all(16),
            initialCameraPosition: iCP,
          );
        },
      ),
    );
  }
}
