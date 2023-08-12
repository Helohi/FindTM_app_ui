part of 'search_bloc.dart';

abstract class SearchEvent {}

class EnteringQueryEvent implements SearchEvent {
  EnteringQueryEvent({required this.isSearching});

  final bool isSearching;
}

class SearchHappendEvent implements SearchEvent {}
