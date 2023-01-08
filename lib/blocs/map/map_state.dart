part of 'map_bloc.dart';

class MapState extends Equatable {
  //
  final bool isMapInitialized;
  final bool isFollowingUser;

  // POLYLINES
  final Map<String, Polyline> polylines;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = true,
    Map<String, Polyline>? polylines,
  }) : polylines = polylines ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? followUser,
    Map<String, Polyline>? polylines,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: followUser ?? isFollowingUser,
        polylines: polylines ?? this.polylines,
      );

  @override
  List<Object> get props => [isMapInitialized, isFollowingUser, polylines];
}
