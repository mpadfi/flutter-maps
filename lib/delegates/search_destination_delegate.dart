import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  //
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result);
      },
    );
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity = BlocProvider.of<LocationBloc>(context).state.lastKnownLocation!;

    searchBloc.getPlacesByQuery(proximity, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;
        return ListView.separated(
          itemCount: places.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final place = places[index];
            return ListTile(
              title: Text(place.text),
              subtitle: Text(place.placeName),
              leading: const Icon(Icons.place_outlined, color: Colors.black),
              onTap: () {
                final result = SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(place.center[1], place.center[0]),
                  name: place.text,
                  description: place.placeName,
                );

                //* DISPARAR EL EVENTO AÑADIR A HISTORIA
                searchBloc.add(OnAddToHistoryEvent(place));

                close(context, result);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //
    final history = BlocProvider.of<SearchBloc>(context).state.history;
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.black),
          title: const Text('Colocar la ubicación manualmente', style: TextStyle(color: Colors.black)),
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),
        //* construir la lista de elementos
        ...history.map(
          (place) => ListTile(
            title: Text(place.text),
            subtitle: Text(place.placeName),
            leading: const Icon(Icons.history, color: Colors.black45),
            onTap: () {
              final result = SearchResult(
                cancel: false,
                manual: false,
                position: LatLng(place.center[1], place.center[0]),
                name: place.text,
                description: place.placeName,
              );
              close(context, result);
            },
          ),
        )
      ],
    );
  }
}
