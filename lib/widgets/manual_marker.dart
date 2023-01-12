import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:maps_app/blocs/blocs.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
        return state.displayManualMarker ? const _ManualMarkerBody() : const SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody();

  @override
  Widget build(BuildContext context) {
    //
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          //* BOTON BACK
          const Positioned(
            top: 70,
            left: 20,
            child: _BtnBack(),
          ),

          //* MARCADOR
          Center(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: BounceInDown(
                from: 100,
                child: const Icon(
                  Icons.location_on_rounded,
                  size: 50,
                ),
              ),
            ),
          ),

          //* BOTON CONFIRMAR
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              from: 200,
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                color: Colors.black,
                elevation: 0,
                height: 50,
                minWidth: size.width - 120,
                shape: const StadiumBorder(),
                onPressed: () async {
                  //* asignamos el punto inicial con la última localización del Location Bloc
                  final start = locationBloc.state.lastKnownLocation;
                  if (start == null) return;

                  //* asignamos el punto final con el mapCenter del Map Bloc
                  final end = mapBloc.mapCenter;
                  if (end == null) return;

                  //* confirmar destino en Search Bloc
                  final destination = await searchBloc.getCoordsStartToEnd(start, end);

                  //* dibujamos la linea con el metodo del mapbloc
                  mapBloc.drawRoutePolyline(destination);
                },
                child: const Text('Confimar Destino', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(microseconds: 300),
      child: CircleAvatar(
        maxRadius: 20,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            //* DESACTIVAR MARCADOR MANUAL
            BlocProvider.of<SearchBloc>(context).add(OnDeactivateManualMarketEvent());
          },
        ),
      ),
    );
  }
}
