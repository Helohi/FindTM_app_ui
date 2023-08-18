part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial implements SearchState {}

// FindTM logo
abstract class UpdateFindTMLogoState implements SearchState {}

class ShowTextFildForQueryState implements UpdateFindTMLogoState {}

class ShowFindTMLogoState implements UpdateFindTMLogoState {}

// Searching states
abstract class UpdateResultsListView implements SearchState {}

class LoadingSearchResultsState implements UpdateResultsListView {}

class ShowResultsOfSearchSate implements UpdateResultsListView {}

class ExceptionSearchState implements UpdateResultsListView {
  ExceptionSearchState({this.errorDetails});

  final String? errorDetails;
}
