part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarketEvent extends SearchEvent {}

class OnDeactivateManualMarketEvent extends SearchEvent {}
